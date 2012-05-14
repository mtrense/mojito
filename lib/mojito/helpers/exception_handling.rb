# encoding: UTF-8

module Mojito
	
	class MojitoException < Exception
		
		def initialize(status = 500, message = STATUS[status].message)
			super(message)
			@status = Mojito::STATUS[status].code
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
						rescue Exception => e
							__handle_error e
						end
					end
				end
			end
			
			def raise(exception)
				backtrace = caller[1..-1]
				Kernel.raise case exception
				when Symbol, Integer
					Mojito::MojitoException.new(exception)
				when Exception
					exception
				else
					RuntimeError.new(exception)
				end.tap {|e| e.set_backtrace backtrace }
			end
			
			def __handle_error(exception)
				if handler = case exception
					when MojitoException
						self.class.error_handlers[exception.status]
					when Exception
						self.class.error_handlers[exception.class]
					end
					instance_exec &handler
				end
				puts "Exception: #{exception.inspect}"
				raise exception
			end
			
			module ClassMethods
				
				def on_error(type, &block)
					case type
					when Symbol, Integer
						error_handlers[Mojito::STATUS[type].code] = block
					when Class
						error_handlers[type] = block
					end
				end
				
				def error_handlers
					@__error_handlers ||= {}
				end
				
			end
			
		end
		
	end

end