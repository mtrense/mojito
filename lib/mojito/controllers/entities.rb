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
			
			def types
				@types ||= {}
			end
			
			def type(t, &block)
				tc = TypeConfiguration.new t
				tc.instance_exec &block if block
				types[t] = tc
			end
			
		end
		
		class TypeConfiguration
			
			def initialize(type)
				@type = type
			end
			
			
			
		end
		
	end
	
end