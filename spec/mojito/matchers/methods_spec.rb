# encoding: UTF-8
require 'simplecov' and SimpleCov.start do
	add_filter "spec/"
end
require 'mojito'

describe Mojito::Matchers::Methods do
	
	subject do
		Mojito.application Mojito::Matchers::Methods do
			on GET() do write 'get' ; halt! end
			on POST() do write 'post' ; halt! end
			on HEAD() do write 'head' ; halt! end
			on PUT() do write 'put' ; halt! end
			on DELETE() do write 'delete' ; halt! end
			on METHOD(:options) do write 'options' ; halt! end
		end.mock_request
	end
	
	it { subject.get('/').body.should == 'get' }
	it { subject.post('/').body.should == 'post' }
	it { subject.head('/').body.should == 'head' }
	it { subject.put('/').body.should == 'put' }
	it { subject.delete('/').body.should == 'delete' }
	it { subject.request('OPTIONS', '/').body.should == 'options' }
	
end
