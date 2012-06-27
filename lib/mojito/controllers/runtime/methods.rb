# encoding: UTF-8

module Mojito::Controllers::Runtime
	
	module Methods
		
		def METHOD(method)
			proc { request.request_method == method.to_s.upcase }
		end
		
		def GET
			METHOD(:get)
		end
		
		def HEAD
			METHOD(:head)
		end
		
		def POST
			METHOD(:post)
		end
		
		def PUT
			METHOD(:put)
		end
		
		def DELETE
			METHOD(:delete)
		end
		
	end
	
end