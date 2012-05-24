# encoding: UTF-8

module Mojito::Matchers
	
	require 'mojito/matchers/environment'
	require 'mojito/matchers/methods'
	require 'mojito/matchers/path'
	require 'mojito/matchers/url_scheme'
	require 'mojito/matchers/virtual_host'
	
	include Environment
	include Methods
	include Path
	include UrlScheme
	include VirtualHost
	
	extend Environment
	extend Methods
	extend Path
	extend UrlScheme
	extend VirtualHost
	
end