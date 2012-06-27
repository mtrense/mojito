# encoding: UTF-8
require 'simplecov' and SimpleCov.start do
	add_filter "spec/"
end
require 'mojito'

describe ::Rack::Request do
	
	subject do
		Mojito::C.runtime_controller Mojito::Rendering::Content do
			write request.GET[:hello]
			halt!
		end.mock_request
	end
	
	it { subject.get('/?hello=world').status.should == 200 }
	it { subject.get('/?hello=world').body.should == 'world' }
	
end