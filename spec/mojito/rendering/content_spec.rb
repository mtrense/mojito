# encoding: UTF-8
require 'simplecov' and SimpleCov.start do
	add_filter "spec/"
end
require 'mojito'

describe Mojito::Rendering::Content do
	
	subject do
		Mojito::C.runtime_controller Mojito::Rendering::Content do
			on do write 'test content' ; halt! end
		end.mock_request
	end
	
	it { subject.get('/').body.should == 'test content' }
	
end
