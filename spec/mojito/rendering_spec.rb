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

describe Mojito::Rendering::Delegation do
	
	subject do
		sub_app = Mojito.base_application Mojito::Rendering::Content, Mojito::Rendering::Delegation do
			on true do write 'sub-application' ; halt! end
		end
		Mojito.base_application Mojito::Rendering::Content, Mojito::Rendering::Delegation do
			on true do run! sub_app end
		end.mock_request
	end
	
	it { subject.get('/').status.should == 200 }
	it { subject.get('/').body.should == 'sub-application' }
	
	context do
		
		subject do
			sub_app = Mojito.base_application Mojito::R::Content, Mojito::R::Delegation do
				on true do write("#{path_info} #{captures.first}") ; halt! end
			end
			Mojito.base_application Mojito::M::Path, Mojito::R::Content, Mojito::R::Delegation do
				on PATH('hello/:name') do run! sub_app end
			end.mock_request
		end
		
		it { subject.get('/hello/world/rest').status.should == 200 }
		it { subject.get('/hello/world/rest').body.should == '/rest world' }

	end
		
end

describe Mojito::Rendering::File do
	
	subject do
		Mojito.base_application Mojito::Rendering::File do
			file! __FILE__
		end.mock_request
	end
	
	it { subject.get('/').status.should == 200 }
	it { subject.get('/').headers.should include('Content-Type') }
	it { subject.get('/').headers['Content-Type'].should == 'application/x-ruby' }
	it { subject.get('/').headers.should include('Content-Length') }
	it { subject.get('/').headers['Content-Length'].should == ::File.size(__FILE__).to_s }
	it { subject.get('/').headers.should include('Last-Modified') }
	it { subject.get('/').headers['Last-Modified'].should == ::File.mtime(__FILE__).rfc2822 }
	it { subject.get('/').body.should == ::File.read(__FILE__) }
	
end
