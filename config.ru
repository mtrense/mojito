# encoding: UTF-8

require 'mojito'

use Rack::ShowExceptions

class TestApp	
	include	 Mojito
	
	routes do
		on 'inline_template/:name' do |name|
			template 'test.html.liquid'
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

run TestApp.to_app