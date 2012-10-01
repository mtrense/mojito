# encoding: UTF-8

module Mojito::Rendering
	
	require 'mojito/rendering/cache'
	require 'mojito/rendering/content'
	require 'mojito/rendering/content_types'
	require 'mojito/rendering/delegation'
	require 'mojito/rendering/file'
	require 'mojito/rendering/markup'
	require 'mojito/rendering/status_codes'
	require 'mojito/rendering/templates'
	
	def self.included(type)
		type.instance_exec do
			include Cache
			include Content
			include ContentTypes
			include Delegation
			include File
			include Markup
			include StatusCodes
			include Templates
		end
	end
	
end
