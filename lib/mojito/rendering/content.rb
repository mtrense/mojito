# encoding: UTF-8

module Mojito::Rendering
	
	module Content
		
		def write(content)
			response.write content
		end
		
		def render_as(type, content, *args)
			renderer = "to_#{type}".to_sym
			if content.respond_to? renderer
				response.write(content.send(renderer, *args[0...content.method(renderer).arity]))
			else
				Mojito::Rendering::StatusCodes.instance_method(:not_found!).bind(self).call
			end
		end
		
	end

end