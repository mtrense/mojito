# encoding: UTF-8

module Mojito::Matchers
	
	module Session

		def SESSION(name)
			proc { request.session.include? name.to_s }
		end
		
	end
	
	Mojito::PLUGINS[:session] = Session
	
end