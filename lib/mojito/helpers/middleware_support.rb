# encoding: UTF-8

module Mojito::Helpers::MiddlewareSupport
	
	def self.included(type)
#		type.instance_exec do
#			call = method(:call)
#			define_singleton_method :call do |env|
#				
#			end
#		end
		type.extend ClassMethods
	end
	
	module ClassMethods
		
		def use(middleware, *args)
			middlewares << [middleware, args]
		end
		
		def middlewares
			@middlewares ||= []
		end
		
	end
	
end