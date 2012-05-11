# encoding: UTF-8

module Mojito::Matchers
	
	module Methods
		
		def get
			proc { request.get? }
		end
		
		def head
			proc { request.head? }
		end
		
		def post
			proc { request.post? }
		end
		
		def put
			proc { request.put? }
		end
		
		def delete
			proc { request.delete? }
		end
		
	end
	
	module Path
		
		def path(pattern)
			proc do
				case pattern
				when String
					__consume_path(pattern.gsub(%r{/?:\?\w+}) {|name| "(?:/(?<#{name[2..-1]}>[^/]+))?" }.gsub(%r{:\w+}) {|name| "(?<#{name[1..-1]}>[^/]+)" })
				when Regexp
					__consume_path(pattern)
				else
					false
				end
			end
		end
		
		def __consume_path(pattern)
			return unless match = path_info.match(%r<\A/#{pattern}(?=/|\z)>)
			env['SCRIPT_NAME'] = match.to_s
			env['PATH_INFO'] = match.post_match
			locals.update match.names.inject({}) {|hash, name| hash[name.to_sym] = match[name] ; hash }
			captures.push *match.captures
			true
		end
		
	end
	
	module VirtualHost
		
		
		
	end
	
	include Methods
	include Path
	include VirtualHost
	
	extend Methods
	extend Path
	extend VirtualHost
	
end