# encoding: UTF-8

module Mojito::Matchers
	
	require 'mojito/matchers/methods'
	require 'mojito/matchers/path'
	require 'mojito/matchers/url_scheme'
	require 'mojito/matchers/virtual_host'
	
	include Methods
	include Path
	include UrlScheme
	include VirtualHost
	
	extend Methods
	extend Path
	extend UrlScheme
	extend VirtualHost
	
end