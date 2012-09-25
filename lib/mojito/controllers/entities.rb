# encoding: UTF-8

module Mojito::Controllers
	
	module Entities
		
		def self.included(type)
			type.extend ClassMethods
		end
		
		def __dispatch
			
			[404, { 'Content-Type' => 'application/octet-stream' }, []]
		end
		
		module ClassMethods
			
			def type(t)
				@type = t
			end
			
		end
		
	end
	
end