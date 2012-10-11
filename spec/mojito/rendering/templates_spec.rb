# encoding: UTF-8
require 'simplecov' and SimpleCov.start do
	add_filter "spec/"
	add_filter "lib/mojito/utils/rspec.rb"
end
require 'mojito'
require 'mojito/utils/rspec'

describe Mojito::Rendering::Templates do
	
	context 'inline templates' do
		subject do
			Mojito::C.runtime_controller Mojito::R::Content, Mojito::R::Templates do
				write template(:erb, 'before <%= var %> <%= yield %> after', :var => 'middle') { 'inside the block' }
				halt!
			end.mock_request
		end
		
		it { subject.get('/').should respond_with(200, 'before middle inside the block after') }
		
	end
	
	context 'file templates' do
		subject do
			Mojito::C.runtime_controller Mojito::R::Content, Mojito::R::Templates do
				write template('test.html.erb', :var => 'middle') { 'inside the block' }
				halt!
			end.mock_request
		end
		
		it { subject.get('/').should respond_with(200, 'HTML file with a variable middle and a yield inside the block', 'Content-Type' => 'text/html') }
		
		context 'text template' do
			subject do
				Mojito::C.runtime_controller Mojito::R::Content, Mojito::R::Templates do
					write template('test.txt.erb', :var => 'middle') { 'inside the block' }
					halt!
				end.mock_request
			end
			
			it { subject.get('/').should respond_with(200, 'Text file with a variable middle and a yield inside the block', 'Content-Type' => 'text/plain') }
			
		end
			
	end

end
