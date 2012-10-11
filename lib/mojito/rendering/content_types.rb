# encoding: UTF-8

module Mojito::Rendering
	
	module ContentTypes
		require 'mime/types'
		
		def content_type(type = :html, charset = 'UTF-8')
			response['Content-Type'] = ContentType.new(type, charset)
		end
		
		class ContentType
			
			def initialize(type, charset = 'UTF-8')
				@raw_type = type
				@mime_types = case type
				when :plain
					MIME::Types.type_for 'txt'
				else
					MIME::Types.type_for type.to_s
				end
				@charset = charset
			end
			
			attr_reader :mime_types, :raw_type, :charset
			
			def mime_type
				mime_types.first
			end
			
			def to_s
				mime_type.to_s + (mime_type.ascii? ? "; charset=#{charset}" : '')
			end
			
		end
		
	end
	
end