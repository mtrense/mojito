# encoding: UTF-8

module Mojito::Helpers::Shortcuts
	
	def captures
		request.captures
	end
	
	def locals
		request.locals
	end
	
	def script_name
		request.script_name
	end
	
	def path_info
		request.path_info
	end
	
	def session
		request.session
	end
	
	module ClassMethods
		
		
		
	end
	
end