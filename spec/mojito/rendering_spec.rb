# encoding: UTF-8
require 'simplecov' and SimpleCov.start do
	add_filter "spec/"
end
require 'mojito'

describe Mojito::Rendering::Content do
	
	subject do
		Mojito.base_application Mojito::Rendering::Content do
			on do write 'test content' ; halt! end
		end.mock_request
	end
	
	it { subject.get('/').body.should == 'test content' }
	
end

describe Mojito::Rendering::StatusCodes do
	
	subject do
		Mojito.base_application Mojito::Matchers::Path, Mojito::Rendering::StatusCodes do
			on 'ok' do ok! end
			on 'not_found' do not_found! end
			on 'internal_server_error' do internal_server_error! end
		end.mock_request
	end
	
	it { subject.get('/ok').status.should == 200 }
	it { subject.get('/not_found').status.should == 404 }
	it { subject.get('/internal_server_error').status.should == 500 }
	
end
