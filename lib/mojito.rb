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
		
	end

end