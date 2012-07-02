# encoding: UTF-8
require 'simplecov' and SimpleCov.start do
	add_filter "spec/"
	add_filter "lib/mojito/utils/rspec.rb"
end
require 'mojito'
require 'mojito/utils/rspec'

describe Mojito::Rendering::File do
	
	subject do
		Mojito::C.runtime_controller Mojito::R::File do
			file! __FILE__
		end.mock_request
	end
	
	it do
		subject.get('/').should respond_with(200, ::File.read(__FILE__),
			'Content-Type' => 'application/x-ruby', 
			'Content-Length' => ::File.size(__FILE__).to_s, 
			'Last-Modified' => ::File.mtime(__FILE__).rfc2822)
	end
	
end
