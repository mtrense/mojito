# encoding: UTF-8

module Mojito::Matchers
	
	module Path
		
		def PATH(pattern)
			consume_path = proc do |pattern|
				if match = path_info.match(%r<\A/#{pattern}(?=/|\z)>)
					env['SCRIPT_NAME'] = match.to_s
					env['PATH_INFO'] = match.post_match
					locals.update match.names.inject({}) {|hash, name| hash[name.to_sym] = match[name] ; hash }
					captures.push *match.captures
					true
				else
					false
				end
			end
			proc do
				if p = case pattern
					when String
						pattern.gsub(%r{/?:\?\w+}) {|name| "(?:/(?<#{name[2..-1]}>[^/]+))?" }.gsub(%r{:\w+}) {|name| "(?<#{name[1..-1]}>[^/]+)" }
					when Regexp
						pattern
					end
					instance_exec p,  &consume_path
				else
					false
				end
			end
		end
		
	end
	
end