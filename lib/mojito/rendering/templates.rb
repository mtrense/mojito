# encoding: UTF-8

module Mojito::Rendering
	
	module Templates
		require 'tilt'
		require 'where'
		require 'mime/types'
		
		def template(*args, &block)
			locals = Hash === args.last ? args.pop : self.locals
			template = if args.size == 2
				Tilt[args.first].new { args.last }
			elsif args.size == 1
				file = Where.cdir(1) + args.first
				if %r{\.(?<extension>\w+)\.\w+$} =~ file.to_s
					response['Content-Type'] = MIME::Types.type_for(extension)
				end
				Tilt[file.to_s].new file.to_s
			end
			response.write template.render(self, locals, &block)
		end
		
	end
	
end