# encoding: UTF-8
require 'mojito'

describe Mojito::Rendering::Content do
	
	subject do
		Mojito.application Mojito::Matchers::Methods do
			on GET() do write 'test content' ; halt! end
		end.mock_request
	end
	
	it { subject.get('/').body.should == 'test content' }
	
end
