# encoding: UTF-8
require 'rack'
require 'extlib'

module Mojito
	require 'mojito/request_extensions'
	require 'mojito/helpers'
	require 'mojito/base'
	require 'mojito/utils/status_codes'
	require 'mojito/rendering'
	require 'mojito/matchers'
	
	R = Rendering
	M = Matchers
	H = Helpers
	
	def self.included(type)
		type.instance_exec do
			ALL_HELPERS.reverse.each do |mod|
				include mod
			end
		end
	end
	
	def self.base_application(*helpers, &block)
		Class.new.tap do |cl|
			cl.instance_exec do
				include Mojito::Base
				helpers.reverse.each do |helper|
					include helper
				end
			end
			cl.routes &block if block
		end		
	end
	
	def self.application(*helpers, &block)
		Class.new.tap do |cl|
			cl.instance_exec do
				include Mojito
				helpers.reverse.each do |helper|
					include helper
				end
			end
			cl.routes &block if block
		end
	end
	
	ALL_HELPERS = [Mojito::Matchers, Mojito::Rendering, Mojito::Helpers::ExceptionHandling, Mojito::Helpers::Shortcuts, Mojito::Base]

end