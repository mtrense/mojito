# encoding: UTF-8
require 'mojito'

describe Mojito::Matchers::Path do
	
	subject { Mojito.application(Mojito::Matchers::Path).new Rack::MockRequest.env_for('http://localhost/hello/world/rest') }
	
	it do
		subject.send(:__match?, subject.path('hello'))
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
		subject.send(:__match?, subject.path('hello/:name'))
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
		subject.send(:__match?, subject.path(%r{hello/(?<name>[^/]+)}))
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