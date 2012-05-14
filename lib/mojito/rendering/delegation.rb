# encoding: UTF-8

module Mojito::Rendering
	
	module Delegation
		
		def run(app)
			halt! app
		end
		
	end
	
end