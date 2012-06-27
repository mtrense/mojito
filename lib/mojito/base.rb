# encoding: UTF-8

require 'mime/types'

module Mojito
	
	module Base
		
		def self.included(type)
			type.extend ClassMethods
		end
		
		def initialize(request)
			@__request = case request 
			when Rack::Request
				request.dup
			when Hash, Mash
				Rack::Request.new(request.dup)
			end
			self.env['MOJITO/CONTEXT_PATH'] = self.env['SCRIPT_NAME']
		end
		
		def env
			request.env
		end
		
		def request
			@__request
		end
		
		def response
			@__response ||= Rack::Response.new.tap do |res|
				res.headers.delete 'Content-Type'
			end
		end
		
		def halt!(resp = response)
			throw :halt, case resp
			when Rack::Response
				resp.tap {|res|
					unless res.headers.include? 'Content-Type'
						if extension = request.path[/(?<=\.)\w+$/] and res.status == 200 and type = MIME::Types.type_for(extension).first
							res.headers['Content-Type'] = type.to_s
						else
							res.headers['Content-Type'] = 'text/html'
						end
					end
				}.finish
			when Array
				resp
			when Symbol, Integer
				response.status = STATUS[resp].code
				response.finish
			else
				[500, { 'Content-Type' => 'text/plain', 'Content-Length' => '0' }, []]
			end
		end
		
	end
	
	module ClassMethods
		
		def call(env)
			catch :halt do
				request = Rack::Request.new env
				call_with_handlers request
			end
		end
		
		def call_with_handlers(request)
			dispatch request
		end
		
		def dispatch(request)
			self.new(request).__dispatch
		end
		
	end
	
end