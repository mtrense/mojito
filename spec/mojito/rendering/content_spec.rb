# encoding: UTF-8
require 'simplecov' and SimpleCov.start do
	add_filter "spec/"
	add_filter "lib/mojito/utils/rspec.rb"
end
require 'mojito'
require 'mojito/utils/rspec'

describe Mojito::Rendering::Content do
	
	subject do
		Mojito::C.runtime_controller Mojito::Rendering::Content do
			on do write 'test content' ; halt! end
		end.mock_request
	end
	
	it { subject.get('/').should respond_with(200, 'test content') }
	
end
