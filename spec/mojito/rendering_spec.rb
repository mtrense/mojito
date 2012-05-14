# encoding: UTF-8
require 'mojito'

describe Mojito::Rendering::Content do
	
	subject do
		Mojito.base_application Mojito::Rendering::Content do
			on do write 'test content' ; halt! end
		end.mock_request
	end
	
	it { subject.get('/').body.should == 'test content' }
	
end
