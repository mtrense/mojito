# encoding: UTF-8
require 'rack'
require 'extlib'

module Mojito
	
	require 'mojito/request_extensions'
	require 'mojito/helpers'
	require 'mojito/controllers'
	require 'mojito/base'
	require 'mojito/utils/status_codes'
	require 'mojito/rendering'
	
	R = Rendering
	H = Helpers
	C = Controllers
	
	class << self
		
		def included(type)
			type.instance_exec do
				include Mojito::Base
			end
			type.extend ClassMethods
		end
		
		def mode
			(ENV['RACK_ENV'] || :development).to_sym
		end
	
		def development?
			mode == :development
		end
		
	end
	
	module ClassMethods
		
		def mock_request
			Rack::MockRequest.new self
		end
		
		def controller(name, options = {})
			mod = Mojito::Controllers.const_get name.to_s.camel_case.to_sym
			include mod
		end
		
		def helper(name, options = {})
			mod = Mojito::Helpers.const_get name.to_s.camel_case.to_sym
			include mod
		end
		
		def rendering(name, options = {})
			mod = case name
			when :all
				Mojito::Rendering
			else
				Mojito::Rendering.const_get name.to_s.camel_case.to_sym
			end
			include mod
		end
		
	end

end