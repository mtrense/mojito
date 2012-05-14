# encoding: UTF-8
require 'rack'
require 'slick/logging'

module Mojito
	require 'mojito/utils/status_codes'
	require 'mojito/helpers'
	require 'mojito/rendering'
	require 'mojito/matchers'
	
	R = Rendering
	M = Matchers
	H = Helpers
	
	def self.included(type)
		type.instance_exec do
			ALL_HELPERS.reverse.each do |mod|
				include mod
			end
		end
	end
	
	def self.application(*helpers, &block)
		Class.new.tap do |cl|
			cl.instance_exec do
				include Mojito
				helpers.reverse.each do |helper|
					include helper
					extend helper::ClassMethods if helper.const_defined? :ClassMethods
				end
			end
			cl.routes &block if block
		end
	end
	
	module Base
	
		def self.included(type)
			type.extend ClassMethods
		end
		
		def initialize(env)
			@__env = env
		end
		
		def env
			@__env
		end
		
		def request
			@__request ||= Rack::Request.new(env)
		end
		
		def response
			@__response ||= Rack::Response.new
		end
		
		def captures
			@__captures ||= []
		end
		
		def locals
			@__locals ||= {}
		end
		
		def script_name
			env['SCRIPT_NAME']
		end
		
		def path_info
			env['PATH_INFO']
		end
		
		def halt!(resp = response)
			throw :halt, case resp
			when Rack::Response
				resp.finish
			when Array
				resp
			when Symbol, Integer
				response.status = STATUS[resp].code
				response.finish
			else
				[500, { 'Content-Type' => 'application/octet-stream' }, []]
			end
		end
		
		def dispatch
			instance_exec &self.class.routes if self.class.routes
			Rack::Response.new [], 404, 'Content-Type' => 'application/octet-stream'
		end
		
		def on(*matchers, &block)
			env_backup = env.dup
			param_size = captures.length
			return unless matchers.all? {|m| __match?(m) }
			params = captures[param_size..-1][0..block.arity].collect {|p| Rack::Utils.unescape(p) }
			instance_exec *params, &block
		ensure
			@__env = env_backup
		end
		
		def __match?(matcher)
			case matcher
			when String, Regexp
				instance_exec &Matchers::PATH(matcher)
			when Proc
				instance_exec &matcher
			else
				matcher
			end
		end
		
		module ClassMethods
			
			def call(env)
				catch :halt do
					new(env).dispatch
				end
			end
			
			def routes(&block)
				@__routing = block if block
				@__routing
			end
			
			def mock_request
				Rack::MockRequest.new self
			end
			
		end

	end
	
	ALL_HELPERS = [Mojito::Matchers, Mojito::Rendering, Mojito::Helpers::ExceptionHandling, Mojito::Base]

end