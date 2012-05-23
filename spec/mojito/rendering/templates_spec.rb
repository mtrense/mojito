# encoding: UTF-8
require 'simplecov' and SimpleCov.start do
	add_filter "spec/"
end
require 'mojito'

describe Mojito::Rendering::Templates do
	
	context 'inline templates' do
		subject do
			Mojito.base_application Mojito::Rendering::Templates do
				template :erb, 'before <%= var %> <%= yield %> after', :var => 'middle' do 'inside the block' end
				halt!
			end.mock_request
		end
		
		it { subject.get('/').status.should == 200 }
		it { subject.get('/').body.should == 'before middle inside the block after' }
		
	end
	
	context 'file templates' do
		subject do
			Mojito.base_application Mojito::Rendering::Templates do
				template 'test.html.erb', :var => 'middle' do 'inside the block' end
				halt!
			end.mock_request
		end
		
		it { subject.get('/').status.should == 200 }
		it { subject.get('/').body.should == 'HTML file with a variable middle and a yield inside the block' }
		it { subject.get('/').headers.should include('Content-Type') }
		it { subject.get('/').headers['Content-Type'].should == 'text/html' }
		
	end

end
