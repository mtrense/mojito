# encoding: UTF-8

module Mojito::Rendering
	
	require 'mojito/rendering/content'
	require 'mojito/rendering/content_types'
	require 'mojito/rendering/delegation'
	require 'mojito/rendering/file'
	require 'mojito/rendering/status_codes'
	require 'mojito/rendering/templates'
	
	def self.included(type)
		type.instance_exec do
			include Content
			include ContentTypes
			include Delegation
			include File
			include StatusCodes
			include Templates
		end
	end
	
end
