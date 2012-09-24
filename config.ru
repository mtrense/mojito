# encoding: UTF-8

require 'mojito'

use Rack::ShowExceptions

class MethodTest
	include Mojito
	include Mojito::C::Method
	include Mojito::Rendering
	
	def test
		write 'This is a test message'
		ok!
	end
	
end

class TestApp	
	include	Mojito
	include Mojito::C::Runtime
	include Mojito::Rendering
	include Mojito::H::ExceptionHandling
	
	routes do
		on 'method' do
			run! MethodTest
		end
		
		on 'inline_template/:name' do |name|
			content_type :plain
			template :liquid, 'Hello {{name}}!'
			ok!
		end
		on 'template/:name' do |name|
			template 'test.html.liquid'
			ok!
		end
		on 'template_xml/:name' do |name|
			template 'test.xml.erb'
			ok!
		end
		
		on 'concatenate' do
			content_type :plain, ''.encoding
			write "start\n"
			on 'with_middle' do
				write "middle ä\n"
			end
			write "end\n"
			ok!
		end
		
		on GET() do
			on PATH('hello/:name') do |name|
				write "Hello #{name}!"
				content_type :plain
				ok!
			end
		end
		on GET() do
			on 'exception' do
				raise 503
			end
			redirect! '/hello/Type+your+name+here'
		end
	end
	
	on_error 503 do
		write "Sorry we're down this time."
		halt!
	end
	
end

run TestApp