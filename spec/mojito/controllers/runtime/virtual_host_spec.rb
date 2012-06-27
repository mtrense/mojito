# encoding: UTF-8
require 'simplecov' and SimpleCov.start do
	add_filter "spec/"
end
require 'mojito'

describe Mojito::Controllers::Runtime::VirtualHost do
	
	subject do
		Mojito::C.runtime_controller Mojito::Controllers::Runtime::VirtualHost, Mojito::R::Content do
			on HOST('localhost') do write 'localhost' ; halt! end
			on HOST('test:8080') do write 'test' ; halt! end
		end.mock_request
	end
	
	it { subject.get('http://localhost:4444/').body.should == 'localhost' }
	it { subject.get('http://localhost/').body.should == 'localhost' }
	it { subject.get('http://localhost:80/').body.should == 'localhost' }
	it { subject.get('http://test:8080/').body.should == 'test' }
	it { subject.get('http://test/').status.should == 404 }
	
end
