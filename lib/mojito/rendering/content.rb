# encoding: UTF-8

module Mojito::Rendering
	
	module Content
		
		def write(content)
			response.write content
		end
		
	end

end