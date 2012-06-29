# encoding: UTF-8
require 'simplecov' and SimpleCov.start do
	add_filter "spec/"
end
require 'mojito'

describe Mojito::Controllers::Method do
	
	subject do
		Mojito::Controllers.method_controller do
			include Mojito::Rendering
			def test_method
				write 'Test method'
				ok!
			end
			def hello(name)
				write "Hello #{name}"
				ok!
			end
			def hello_all(first_name, *names)
				write "Hello #{[first_name, *names].join(', ')}"
				ok!
			end
		end.mock_request
	end
	
	it { subject.get('/test_method').status.should == 200 }
	it { subject.get('/test_method').body.should == 'Test method' }
	
	it { subject.get('/hello/Fred').status.should == 200 }
	it { subject.get('/hello/Fred').body.should == 'Hello Fred' }
	
	it { subject.get('/hello').status.should == 404 }
	
	it { subject.get('/hello_all/Fred/Barney').status.should == 200 }
	it { subject.get('/hello_all/Fred/Barney').body.should == 'Hello Fred, Barney' }
	it { subject.get('/hello_all/Fred/Barney/Wilma').body.should == 'Hello Fred, Barney, Wilma' }

end