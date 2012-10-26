# encoding: UTF-8
require 'simplecov' and SimpleCov.start do
	add_filter "spec/"
	add_filter "lib/mojito/utils/rspec.rb"
end
require 'mojito'
require 'mojito/utils/rspec'

describe Mojito do
  
	context do
		subject { Mojito::C.runtime_controller {} }
		it { subject.ancestors.should include(Mojito::Base) }
		it { subject.should respond_to(:call) }
	end
	
	context do
		subject { Mojito::C.runtime_controller(Mojito::H::Shortcuts).new Rack::MockRequest.env_for('http://localhost/hello/world/rest') }
		it { subject.env.should_not be_nil }
		it { subject.request.should be_kind_of(Rack::Request) }
		it { subject.captures.should be_empty }
		it { subject.locals.should be_empty }
		it do
			subject.send(:__match?, proc { request.host == 'localhost' })
			subject.captures.should be_empty
			subject.locals.should be_empty
			subject.path_info.should == '/hello/world/rest'
		end
	end
	
	context do
		before { ENV['RACK_ENV'] = 'development:my_mode:publish' }
		subject { Mojito }
		it { subject.mode.should == :development }
		it do
			subject.modes.should include(:development)
			subject.modes.should include(:publish)
			subject.modes.should include(:my_mode)
		end
	end
	
	context do
		subject do
			Mojito::C.runtime_controller do
				
			end
		end
	end
	
end
