# encoding: UTF-8

module Mojito::Rendering
	
	module StatusCodes
		
		%W[ok not_found unauthorized internal_server_error service_unavailable forbidden].each do |status|
			eval <<-EVAL
			def #{status}!
				response.status = #{Mojito::STATUS[status.to_sym].code}
				halt!
			end
			EVAL
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