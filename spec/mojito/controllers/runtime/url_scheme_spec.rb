# encoding: UTF-8
require 'simplecov' and SimpleCov.start do
	add_filter "spec/"
	add_filter "lib/mojito/utils/rspec.rb"
end
require 'mojito'
require 'mojito/utils/rspec'

describe Mojito::Controllers::Runtime::UrlScheme do
	
	subject do
		Mojito::C.runtime_controller Mojito::Controllers::Runtime::UrlScheme, Mojito::R::Content do
			on SCHEME(:http) do write 'insecure' ; halt! end
			on SCHEME(:https) do write 'secure' ; halt! end
		end.mock_request
	end
	
	it { subject.get('http://localhost/').should respond_with(200, 'insecure') }
	it { subject.get('http://localhost:7777/').should respond_with(200, 'insecure') }
	it { subject.get('https://localhost:80/').should respond_with(200, 'secure') }
	it { subject.get('https://localhost/').should respond_with(200, 'secure') }
	it { subject.get('otherprotocol://test/').should respond_with(404) }
	
end
