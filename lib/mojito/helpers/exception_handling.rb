# encoding: UTF-8

module Mojito
	
	class MojitoException < Exception
		
		def initialize(status = 500, message = STATUS[status].message)
			super(message)
			@status = status
		end
		
		attr_reader :status
		
		def to_response
			Rack::Response.new [], status, 'Content-Type' => 'application/octet-stream'
		end
		
	end
	
	module Helpers
	
		module ExceptionHandling
			
			def self.included(type)
				type.extend ClassMethods
				type.instance_exec do
					old_dispatch = instance_method(:dispatch)
					define_method :dispatch do
						begin
							old_dispatch.bind(self).call
						rescue => e
							__handle_error e
						end
					end
				end
			end
			
			def __handle_error(exception)
				
			end
			
			module ClassMethods
				
				def on_error(type, &block)
					error_handlers[type] = block
				end
				
				def error_handlers
					@__error_handlers ||= {}
				end
				
			end
			
		end
		
	end

end