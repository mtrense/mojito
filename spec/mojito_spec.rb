# encoding: UTF-8
require 'mojito'

describe Mojito do
  
	context do
		subject { Mojito.application {} }
		it { subject.ancestors.should include(Mojito) }
	end
	
	context do
		subject { Mojito.application.new Rack::MockRequest.env_for('http://localhost/hello/world/rest') }
		it { subject.env.should_not be_nil }
		it { subject.request.should be_kind_of(Rack::Request) }
		it { subject.captures.should be_empty }
		it { subject.locals.should be_empty }
		it do
			subject.send(:__consume_path, "hello")
			subject.captures.should be_empty
			subject.locals.should be_empty
			subject.path_info.should == '/world/rest'
		end
		it do
			subject.send(:__consume_path, "hello/(?<name>[^/]+)")
			subject.captures.should == ['world']
			subject.locals.should == { :name => 'world' }
			subject.path_info.should == '/rest'
		end
		it do
			subject.send(:__consume_path, %r|hello/([^/]+)|)
			subject.captures.should == ['world']
			subject.locals.should be_empty
			subject.path_info.should == '/rest'
		end
		it do
			subject.send(:__match, subject.path('hello'))
			subject.captures.should be_empty
			subject.locals.should be_empty
			subject.path_info.should == '/world/rest'
		end
		it do
			subject.send(:__match, subject.path('hello/:name'))
			subject.captures.should == ['world']
			subject.locals.should == { :name => 'world' }
			subject.path_info.should == '/rest'
		end
		it do
			subject.send(:__match, proc { request.host == 'localhost' })
			subject.captures.should be_empty
			subject.locals.should be_empty
			subject.path_info.should == '/hello/world/rest'
		end
	end
	
	context do
		subject do
			Mojito.application do
				
			end
		end
	end
	
end
