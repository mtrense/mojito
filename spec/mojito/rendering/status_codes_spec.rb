# encoding: UTF-8
require 'simplecov' and SimpleCov.start do
	add_filter "spec/"
	add_filter "lib/mojito/utils/rspec.rb"
end
require 'mojito'
require 'mojito/utils/rspec'

describe Mojito::Rendering::StatusCodes do
	
	subject do
		Mojito::C.runtime_controller Mojito::R::StatusCodes do
			on 'ok' do ok! end
			on 'not_found' do not_found! end
			on 'internal_server_error' do internal_server_error! end
			on 'service_unavailable' do service_unavailable! end
			on 'redirect' do redirect! '/test' end
		end.mock_request
	end
	
	it { subject.get('/ok').status.should == 200 }
	it { subject.get('/not_found').status.should == 404 }
	it { subject.get('/internal_server_error').status.should == 500 }
	it { subject.get('/service_unavailable').status.should == 503 }
	it { subject.get('/redirect').should respond_with(302, 'Location' => '/test') }
	
end
