# encoding: UTF-8

module Mojito::Matchers
	
	module UrlScheme
		
		def SCHEME(scheme)
			proc do
				case scheme
				when :https, :secure
					request.scheme === 'https'
				when :http, nil
					request.scheme === 'http'
				else
					request.scheme === scheme.to_s
				end
			end
		end
		
	end
	
end
