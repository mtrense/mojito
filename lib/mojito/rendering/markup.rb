# encoding: UTF-8

module Mojito::Rendering
	
	module Markup
		require 'json_builder'
		
		def generate_json(&block)
			JSONBuilder::Compiler.generate(&block)
		end
		
	end
	
end