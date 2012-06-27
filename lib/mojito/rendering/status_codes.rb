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
			response.redirect(target, status)
		end
		
		def redirect!(target, status = 302)
			redirect target, status
			halt!
		end
		
	end
	
end