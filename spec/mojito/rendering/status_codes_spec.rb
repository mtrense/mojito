# encoding: UTF-8
require 'simplecov' and SimpleCov.start do
	add_filter "spec/"
end
require 'mojito'

describe Mojito::Rendering::StatusCodes do
	
	subject do
		Mojito::C.runtime_controller Mojito::R::StatusCodes do
			on 'ok' do ok! end
			on 'not_found' do not_found! end
			on 'internal_server_error' do internal_server_error! end
			on 'unavailable' do unavailable! end
			on 'redirect' do redirect! '/test' end
		end.mock_request
	end
	
	it { subject.get('/ok').status.should == 200 }
	it { subject.get('/not_found').status.should == 404 }
	it { subject.get('/internal_server_error').status.should == 500 }
	it { subject.get('/unavailable').status.should == 503 }
	it { subject.get('/redirect').status.should == 302 }
	it { subject.get('/redirect').headers['Location'].should == '/test' }
	
end
