# encoding: UTF-8

module Mojito::Matchers
	
	require 'mojito/matchers/methods'
	require 'mojito/matchers/path'
	require 'mojito/matchers/virtual_host'
	
	include Methods
	include Path
	include VirtualHost
	
	extend Path
	extend VirtualHost
	
end