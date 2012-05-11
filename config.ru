# encoding: UTF-8

require 'mojito'

M = Mojito

TestApp = M::application M::R, M::M, M::H::ExceptionHandling do
	on path('hello/:name') do |name|
		write "Hello #{name}!"
		content_type :plain
		ok!
	end
	on get do
		redirect! '/hello/Type+your+name+here'
	end
end

run TestApp