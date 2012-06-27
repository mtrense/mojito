# encoding: UTF-8
require 'simplecov' and SimpleCov.start do
	add_filter "spec/"
end
require 'mojito'

describe Mojito::Controllers::Runtime::UrlScheme do
	
	subject do
		Mojito::C.runtime_controller Mojito::Controllers::Runtime::UrlScheme, Mojito::R::Content do
			on SCHEME(:http) do write 'insecure' ; halt! end
			on SCHEME(:https) do write 'secure' ; halt! end
		end.mock_request
	end
	
	it { subject.get('http://localhost/').body.should == 'insecure' }
	it { subject.get('http://localhost:7777/').body.should == 'insecure' }
	it { subject.get('https://localhost:80/').body.should == 'secure' }
	it { subject.get('https://localhost/').body.should == 'secure' }
	it { subject.get('otherprotocol://test/').status.should == 404 }
	
end
