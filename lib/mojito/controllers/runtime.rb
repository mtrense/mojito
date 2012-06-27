# encoding: UTF-8

module Mojito::Controllers
	
	module Runtime
		require 'mojito/controllers/runtime/environment'
		require 'mojito/controllers/runtime/methods'
		require 'mojito/controllers/runtime/path'
		require 'mojito/controllers/runtime/url_scheme'
		require 'mojito/controllers/runtime/virtual_host'
		
		def self.included(type)
			type.extend ClassMethods
			type.instance_exec do
				include Environment
				include Methods
				include Path
				include UrlScheme
				include VirtualHost
			end
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
				instance_exec &PATH(matcher)
			when Proc
				instance_exec &matcher
			else
				matcher
			end
		end
		private :__match?
		
		##
		# Dispatches the current request to the matching routes.
		def __dispatch
			instance_exec &self.class.routes if self.class.routes
			[404, { 'Content-Type' => 'application/octet-stream' }, []]
		end
		
		module ClassMethods
			
			def routes(&block)
				@routes = block if block
				@routes
			end
			
		end
		
	end
	
	def self.runtime_controller(*modules, &block)
		Class.new do
			include Mojito
			include Mojito::C::Runtime
			modules.each do |mod|
				include mod
			end
			routes &block
		end
	end
	
end