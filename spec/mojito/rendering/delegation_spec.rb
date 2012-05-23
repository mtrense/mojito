# encoding: UTF-8
require 'simplecov' and SimpleCov.start do
	add_filter "spec/"
end
require 'mojito'

describe Mojito::Rendering::Delegation do
	
	subject do
		sub_app = Mojito.base_application Mojito::R::Content, Mojito::R::Delegation do
			on true do write 'sub-application' ; halt! end
		end
		Mojito.base_application Mojito::Rendering::Content, Mojito::Rendering::Delegation do
			on true do run! sub_app end
		end.mock_request
	end
	
	it { subject.get('/').status.should == 200 }
	it { subject.get('/').body.should == 'sub-application' }
	
	context do
		
		subject do
			sub_app = Mojito.base_application Mojito::R::Content, Mojito::R::Delegation, Mojito::H::Shortcuts do
				on true do write("#{path_info} #{captures.first}") ; halt! end
			end
			Mojito.base_application Mojito::M::Path, Mojito::R::Content, Mojito::R::Delegation do
				on PATH('hello/:name') do run! sub_app end
			end.mock_request
		end
		
		it { subject.get('/hello/world/rest').status.should == 200 }
		it { subject.get('/hello/world/rest').body.should == '/rest world' }

	end
		
end
