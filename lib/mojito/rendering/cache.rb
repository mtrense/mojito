# encoding: UTF-8

module Mojito::Rendering
	
	module Cache
		
		def cache(*args)
			options = Hash === args.last ? args.pop : {}
			directive = args.first || :public
			response['Cache-Control'] = directive.to_s
		end
		
	end
	
end