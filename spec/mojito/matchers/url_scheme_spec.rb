# encoding: UTF-8
require 'simplecov' and SimpleCov.start do
	add_filter "spec/"
end
require 'mojito'

describe Mojito::Matchers::UrlScheme do
	
	subject do
		Mojito.application Mojito::Matchers::UrlScheme do
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
