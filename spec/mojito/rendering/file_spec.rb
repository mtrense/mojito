# encoding: UTF-8
require 'simplecov' and SimpleCov.start do
	add_filter "spec/"
	add_filter "lib/mojito/utils/rspec.rb"
end
require 'mojito'
require 'mojito/utils/rspec'

describe Mojito::Rendering::File do
	
	subject do
		Mojito::C.runtime_controller Mojito::R::File do
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
