# encoding: UTF-8

module Mojito::Rendering
	
	module File
		require 'pathname'
		require 'mime/types'
		require 'time'
		
		def file!(filename)
			path = Pathname === filename ? filename : Pathname.new(filename.to_s)
			restrict_path! path if respond_to? :restrict_path!
			if path.readable? and path.file?
				body = FileResponse.new path
				halt! [response.status, response.headers.merge(body.compute_headers), body]
			else
				not_found!
			end
		end
		
		class FileResponse
			
			def initialize(pathname)
				@pathname = pathname
			end
			
			def each(&block)
				@pathname.open do |f|
					yield f.read
				end
			end
			
			def compute_headers
				{ 'Content-Type' => mime_type.to_s, 'Content-Length' => size.to_s, 'Last-Modified' => @pathname.mtime.rfc2822 }
			end
			
			def mime_type
				MIME::Types.type_for(@pathname.to_s).first || MIME::Types['application/octet-stream'].first
			end
			
			def size
				@pathname.size
			end
			
			def to_path
				@pathname.to_s
			end
			
		end
		
	end
	
end