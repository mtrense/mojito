# encoding: UTF-8
require 'mojito'

describe Mojito do
  
	context do
		subject { Mojito.application {} }
		it { subject.ancestors.should include(Mojito) }
	end
	
	context do
		subject { Mojito.application(Mojito::Matchers::Path).new Rack::MockRequest.env_for('http://localhost/hello/world/rest') }
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
		subject do
			Mojito.application do
				
			end
		end
	end
	
end
