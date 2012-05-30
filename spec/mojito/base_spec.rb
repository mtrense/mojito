# encoding: UTF-8
require 'simplecov' and SimpleCov.start do
	add_filter "spec/"
end
require 'mojito'

describe Mojito::Base do
	
	subject do
		Mojito.base_application :status_codes do
			on Mojito::Matchers::PATH('test.:extension') do ok! end
		end.mock_request
	end
	
	it { subject.get('/test.html').headers.should include('Content-Type') }
	it { subject.get('/test.html').headers['Content-Type'].should == 'text/html' }
	it { subject.get('/test.txt').headers.should include('Content-Type') }
	it { subject.get('/test.txt').headers['Content-Type'].should == 'text/plain' }
	it { subject.get('/test.rb').headers.should include('Content-Type') }
	it { subject.get('/test.rb').headers['Content-Type'].should == 'application/x-ruby' }
	
end