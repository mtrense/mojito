# encoding: UTF-8
require 'simplecov' and SimpleCov.start do
	add_filter "spec/"
	add_filter "lib/mojito/utils/rspec.rb"
end
require 'mojito'
require 'mojito/utils/rspec'

describe Mojito::Controllers::Method do
	
	subject do
		Mojito::Controllers.method_controller(Mojito::Rendering) do
			def test_method
				write 'Test method'
			end
			def hello(name)
				write "Hello #{name}"
			end
			def hello_all(first_name, *names)
				write "Hello #{[first_name, *names].join(', ')}"
			end
		end.mock_request
	end
	
	it { subject.get('/test_method').should respond_with(200, 'Test method') }
	
	it { subject.get('/hello/Fred').should respond_with(200, 'Hello Fred') }
	
	it { subject.get('/hello').should respond_with(404) }
	
	it { subject.get('/hello_all/Fred/Barney').should respond_with(200, 'Hello Fred, Barney') }
	it { subject.get('/hello_all/Fred/Barney/Wilma').should respond_with(200, 'Hello Fred, Barney, Wilma') }

	it { subject.get('/hello_all').should respond_with(404) }
	
	it { subject.get('/not_defined_method').should respond_with(404) }
	
end