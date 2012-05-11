# encoding: UTF-8

module Mojito::Rendering
	
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
	
end