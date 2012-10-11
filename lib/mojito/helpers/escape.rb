# encoding: UTF-8

module Mojito::Helpers
	
	module Escape
		require 'cgi'
		
		def html(string)
			CGI.escape_html string
		end
		
	end
	
end