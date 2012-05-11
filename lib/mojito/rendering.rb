# encoding: UTF-8

module Mojito::Rendering
	
	module StatusCodes
		
		def ok!
			response.status = 200
			halt!
		end
		
		def not_found!
			response.status = 404
			halt!
		end
		
		def internal_server_error!
			response.status = 500
			halt!
		end
		
		def unavailable!
			response.status = 503
			halt!
		end
		
		def redirect(target, status = 302)
			response['Location'] = target
			response.status = status
		end
		
		def redirect!(target, status = 302)
			redirect target, status
			halt!
		end
		
	end
	
	module ContentTypes
		require 'mime/types'
		
		def content_type(type = :html, charset = 'UTF-8')
			t = case type
			when :plain
				MIME::Types.type_for 'txt'
			else
				MIME::Types.type_for type.to_s
			end.first
			response['Content-Type'] = t.to_s + (t.ascii? ? "; charset=#{charset}" : '')
		end
		
	end
	
	module Content
		
		def write(content)
			response.write content
		end
		
	end
	
	include StatusCodes
	include Content
	include ContentTypes
	
end
