# encoding: UTF-8

module Mojito::Rendering
	
	require 'mojito/rendering/content'
	require 'mojito/rendering/content_types'
	require 'mojito/rendering/delegation'
	require 'mojito/rendering/status_codes'
	
	include Content
	include ContentTypes
	include Delegation
	include StatusCodes
	
end
