# encoding: UTF-8

module Mojito::Controllers::Runtime
	
	module Session

		def SESSION(name)
			proc { request.session.include? name.to_s }
		end
		
	end
	
end