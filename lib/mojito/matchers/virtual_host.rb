# encoding: UTF-8

module Mojito::Matchers
	
	module VirtualHost
		
		def HOST(pattern)
			proc do
				case pattern
				when String
					/#{pattern.gsub('**', '[^:]+').gsub('*', '[^:.]+')}/ === request.host_with_port
				when Array
					pattern.any? {|p| /#{p.gsub('**', '[^:]+').gsub('*', '[^:.]+')}/ === request.host_with_port }
				when Regexp
					pattern === request.host_with_port
				end
			end
		end
		
	end
	
	Mojito::PLUGINS[:virtual_host] = VirtualHost
	
end