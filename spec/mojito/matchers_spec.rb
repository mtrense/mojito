# encoding: UTF-8
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

describe Mojito::Matchers::Path do
	
	subject { Mojito.application.new Rack::MockRequest.env_for('http://localhost/hello/world/rest') }
	
	it do
		subject.send(:__match?, Mojito::M::PATH('hello'))
		subject.captures.should be_empty
		subject.locals.should be_empty
		subject.path_info.should == '/world/rest'
	end
	
	it do
		subject.send(:__match?, 'hello')
		subject.captures.should be_empty
		subject.locals.should be_empty
		subject.path_info.should == '/world/rest'
	end
	
	it do
		subject.send(:__match?, Mojito::M::PATH('hello/:name'))
		subject.captures.should == ['world']
		subject.locals.should == { :name => 'world' }
		subject.path_info.should == '/rest'
	end
	
	it do
		subject.send(:__match?, 'hello/:name')
		subject.captures.should == ['world']
		subject.locals.should == { :name => 'world' }
		subject.path_info.should == '/rest'
	end
	
	it do
		subject.send(:__match?, Mojito::M::PATH(%r{hello/(?<name>[^/]+)}))
		subject.captures.should == ['world']
		subject.locals.should == { :name => 'world' }
		subject.path_info.should == '/rest'
	end
	
	it do
		subject.send(:__match?, %r{hello/(?<name>[^/]+)})
		subject.captures.should == ['world']
		subject.locals.should == { :name => 'world' }
		subject.path_info.should == '/rest'
	end
	
end

describe Mojito::Matchers::VirtualHost do
	
	subject do
		Mojito.application Mojito::Matchers::VirtualHost do
			on HOST('localhost') do write 'localhost' ; halt! end
			on HOST('test:8080') do write 'test' ; halt! end
		end.mock_request
	end
	
	it { subject.get('http://localhost:4444/').body.should == 'localhost' }
	it { subject.get('http://localhost/').body.should == 'localhost' }
	it { subject.get('http://localhost:80/').body.should == 'localhost' }
	it { subject.get('http://test:8080/').body.should == 'test' }
	it { subject.get('http://test/').status.should == 404 }
	
end
