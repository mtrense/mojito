# encoding: UTF-8
require 'simplecov' and SimpleCov.start do
	add_filter "spec/"
	add_filter "lib/mojito/utils/rspec.rb"
end
require 'mojito'
require 'mojito/utils/rspec'

describe Mojito::Controllers::Runtime::Path do
	
	subject { Mojito::C.runtime_controller(Mojito::H::Shortcuts).new Rack::MockRequest.env_for('http://localhost/hello/world/rest') }
	
	it do
		subject.send(:__match?, subject.PATH('hello'))
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
		subject.send(:__match?, subject.PATH('hello/:name'))
		subject.request.captures.should == ['world']
		subject.request.locals.should == { 'name' => 'world' }
		subject.request.path_info.should == '/rest'
	end
	
	it do
		subject.send(:__match?, 'hello/:name')
		subject.request.captures.should == ['world']
		subject.request.locals.should == { 'name' => 'world' }
		subject.request.path_info.should == '/rest'
	end
	
	it do
		subject.send(:__match?, subject.PATH(%r{hello/(?<name>[^/]+)}))
		subject.request.captures.should == ['world']
		subject.request.locals.should == { 'name' => 'world' }
		subject.request.path_info.should == '/rest'
	end
	
	it do
		subject.send(:__match?, %r{hello/(?<name>[^/]+)})
		subject.request.captures.should == ['world']
		subject.request.locals.should == { 'name' => 'world' }
		subject.request.path_info.should == '/rest'
	end
	
	context do
		subject do
			Mojito::C.runtime_controller Mojito::R::Content do
				on PATH('hello/:name') do
					on PATH('another/:name') do
						write request.locals[:name]
						halt!
					end
					write request.locals[:name]
					halt!
				end
			end.mock_request
		end
		
		it { subject.get('/hello/Fred').status.should == 200 }
		it { subject.get('/hello/Fred').body.should == 'Fred' }
		it { subject.get('/hello/Fred/another/Barney').status.should == 200 }
		it { subject.get('/hello/Fred/another/Barney').body.should == 'Barney' }
		
	end
	
end
