# encoding: UTF-8

require 'rspec/expectations'

RSpec::Matchers.define :respond_with do |*args|
	status = if Integer === args.first
		args.shift 
	else
		nil
	end
	headers = if Hash === args.last
		args.pop
	else
		{}
	end
	body = args.first
	
	match do |actual|
		(status ? actual.status == status : true) and
		(body ? actual.body == body : true) and
		headers.all? do |name, value|
			actual.headers[name] == value
		end
	end
	
end