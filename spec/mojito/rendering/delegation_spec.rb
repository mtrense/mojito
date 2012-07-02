# encoding: UTF-8
require 'simplecov' and SimpleCov.start do
	add_filter "spec/"
	add_filter "lib/mojito/utils/rspec.rb"
end
require 'mojito'
require 'mojito/utils/rspec'

describe Mojito::Rendering::Delegation do
	
	subject do
		sub_app = Mojito::C.runtime_controller Mojito::H::Shortcuts, Mojito::R::Content do
			on PATH('this/is/the/sub-application') do write request.context_path ; halt! end
			on true do write 'sub-application' ; halt! end
		end
		Mojito::C.runtime_controller Mojito::R::Content, Mojito::R::Delegation do
			on 'to/sub/app' do run! sub_app end
		end.mock_request
	end
	
	it { subject.get('/to/sub/app').should respond_with(200, 'sub-application') }
	it { subject.get('/to/sub/app/this/is/the/sub-application').should respond_with(200, '/to/sub/app') }
	
	context do
		
		subject do
			sub_app = Mojito::C.runtime_controller Mojito::R::Content, Mojito::H::Shortcuts do
				on true do write("#{path_info} #{captures.first}") ; halt! end
			end
			Mojito::C.runtime_controller Mojito::R::Content, Mojito::R::Delegation do
				on PATH('hello/:name') do run! sub_app end
			end.mock_request
		end
		
		it { subject.get('/hello/world/rest').should respond_with(200, '/rest world') }

	end
		
end
