# encoding: UTF-8
require 'simplecov' and SimpleCov.start do
	add_filter "spec/"
end
require 'mojito'

describe Mojito::Base do
	
	subject do
		Mojito::C.runtime_controller Mojito::R::StatusCodes do
			on PATH('test.:extension') do ok! end
		end.mock_request
	end
	
	it { subject.get('/test.html').headers.should include('Content-Type') }
	it { subject.get('/test.html').headers['Content-Type'].should == 'text/html' }
	it { subject.get('/test.txt').headers.should include('Content-Type') }
	it { subject.get('/test.txt').headers['Content-Type'].should == 'text/plain' }
	it { subject.get('/test.rb').headers.should include('Content-Type') }
	it { subject.get('/test.rb').headers['Content-Type'].should == 'application/x-ruby' }
	
	context do
		
		subject do
			Class.new.tap do |c|
				c.class_exec do
					include Mojito::Base
				end
			end
		end
		
		it { subject.should respond_to(:new).with(1).argument }
		it { subject.should respond_to(:call).with(1).argument }
		it { subject.should respond_to(:dispatch).with(1).argument }
		
	end
		
end