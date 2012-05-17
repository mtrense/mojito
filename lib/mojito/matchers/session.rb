# encoding: UTF-8

module Mojito::Matchers
	
	module Session

		def SESSION(name)
			proc do
				request.session.include? name.to_s
			end
		end
		
	end
	
end