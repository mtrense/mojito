# encoding: UTF-8

module Mojito::Helpers::Restrictions
	
	def self.included(type)
		type.extend ClassMethods
	end
	

	
	module ClassMethods
		
		def restrict(&block)
			
		end
		
	end
	
	module PathRestriction
		
		def restrict_path!(path)
			
		end
		
	end
	
end