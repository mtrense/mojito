# encoding: UTF-8
require 'simplecov' and SimpleCov.start do
	add_filter "spec/"
	add_filter "lib/mojito/utils/rspec.rb"
end
require 'mojito'
require 'mojito/utils/rspec'

describe Mojito::Controllers::Method do
	
	context do
		subject { Mojito::Controllers::Method }
		
		it { subject.args_for(0, '').should == [[], ''] }
		it { subject.args_for(0, 'Fred/Barney').should == [[], 'Fred/Barney'] }
		it { subject.args_for(1, 'Fred').should == [['Fred'], ''] }
		it { subject.args_for(1, 'Fred/Barney').should == [['Fred'], 'Barney'] }
		it { subject.args_for(2, 'Fred/Barney/Wilma').should == [['Fred', 'Barney'], 'Wilma'] }
		it { subject.args_for(-1, 'Fred/Barney/Wilma').should == [['Fred', 'Barney', 'Wilma'], ''] }
		it { subject.args_for(-1, '').should == [[], ''] }
		it { subject.args_for(-2, '').should == [nil, ''] }
		it { subject.args_for(-4, 'Fred/Barney').should == [nil, 'Fred/Barney'] }
		
	end
	
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
	it { subject.get('/test_method/another_parameter').should respond_with(200, 'Test method') }
	
	it { subject.get('/hello/Fred').should respond_with(200, 'Hello Fred') }
	it { subject.get('/hello/Fred+Flintstone').should respond_with(200, 'Hello Fred Flintstone') }
	it { subject.get('/hello/Fred/Barney').should respond_with(200, 'Hello Fred') }
	
	it { subject.get('/hello').should respond_with(404) }
	
	it { subject.get('/hello_all/Fred/Barney').should respond_with(200, 'Hello Fred, Barney') }
	it { subject.get('/hello_all/Fred/Barney/Wilma').should respond_with(200, 'Hello Fred, Barney, Wilma') }

	it { subject.get('/hello_all').should respond_with(404) }
	
	it { subject.get('/not_defined_method').should respond_with(404) }
	
end