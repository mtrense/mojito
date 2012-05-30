# encoding: UTF-8

module Mojito::Rendering
	
	module Delegation
		
		def run!(app)
			halt! app.call(env)
		end
		
	end
	
	Mojito::PLUGINS[:delegation] = Delegation
	
end