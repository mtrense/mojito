# encoding: UTF-8
require 'simplecov' and SimpleCov.start do
	add_filter "spec/"
	add_filter "lib/mojito/utils/rspec.rb"
end
require 'mojito'
require 'mojito/utils/rspec'

describe Mojito::Controllers::Runtime::VirtualHost do
	
	subject do
		Mojito::C.runtime_controller Mojito::Controllers::Runtime::VirtualHost, Mojito::R::Content do
			on HOST('localhost') do write 'localhost' ; halt! end
			on HOST('test:8080') do write 'test' ; halt! end
		end.mock_request
	end
	
	it { subject.get('http://localhost:4444/').should respond_with(200, 'localhost') }
	it { subject.get('http://localhost/').should respond_with(200, 'localhost') }
	it { subject.get('http://localhost:80/').should respond_with(200, 'localhost') }
	it { subject.get('http://test:8080/').should respond_with(200, 'test') }
	it { subject.get('http://test/').should respond_with(404) }
	
end
