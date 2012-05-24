# encoding: UTF-8

module Mojito::Matchers
	
	module Environment
		
		def MODE(mode)
			proc { Mojito.mode == mode.to_sym }
		end
		
	end
	
end