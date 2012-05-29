# encoding: UTF-8

require 'mime/types'

module Mojito
	
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
				[500, { 'Content-Type' => 'text/plain', 'Content-Length' => '0' }, []]
			end
		end
		
		##
		# Dispatches the current request to the matching routes.
		def dispatch
			instance_exec &self.class.routes if self.class.routes
			[404, { 'Content-Type' => 'application/octet-stream' }, []]
		end
		
		##
		# Defines a route which is matched when all given matchers evaluate to +true+.
		def on(*matchers, &block)
			env_backup = env.dup
			param_size = request.captures.length
			return unless matchers.all? {|m| __match?(m) }
			params = request.captures[param_size..-1][0..block.arity].collect {|p| Rack::Utils.unescape(p) }
			instance_exec *params, &block
		ensure
			@__env = env_backup
			request.instance_exec { @env = env_backup }
		end
		
		##
		# Evaluates a single matcher, returning whether it matched or not. Please be aware that matchers (most prominently 
		# the PATH matcher) may alter the current request, however a matcher is only allowed to do that when it matches.
		def __match?(matcher)
			case matcher
			when String, Regexp
				instance_exec &Mojito::Matchers::PATH(matcher)
			when Proc
				instance_exec &matcher
			else
				matcher
			end
		end
		private :__match?
		
		module ClassMethods
			
			def call(env)
				extension = env['PATH_INFO'][/(?<=\.)\w+$/]
				response = catch :halt do
					new(env).dispatch
				end
				unless response[1].include? 'Content-Type'
					type = MIME::Types.type_for(extension).first
					response[1]['Content-Type'] = type if type
				end
				response
			end
			
			def routes(&block)
				@__routing = block if block
				@__routing
			end
			
			def to_app
				self
			end
			
			def mock_request
				Rack::MockRequest.new self
			end
			
		end
		
	end
	
end