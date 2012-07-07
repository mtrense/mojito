# encoding: UTF-8

module Mojito::Controllers
	
	module Method
		
		def __dispatch
			if m = %r{^/?(?<meth>\w+)(?:/|$)}.match(request.path_info)
				meth = m['meth'].to_sym
				if respond_to?(meth.to_sym)
					env['SCRIPT_NAME'] += m.to_s
					arity = method(meth).arity
					args, env['PATH_INFO'] = Method.args_for(arity, m.post_match)
					if args
						send meth, *args
						ok!
					else
						Mojito::R::StatusCodes.instance_method(:not_found!).bind(self).call
					end
				else
					Mojito::R::StatusCodes.instance_method(:not_found!).bind(self).call
				end
			else
				Mojito::R::StatusCodes.instance_method(:not_found!).bind(self).call
			end
		end
		
		def self.args_for(arity, path_info)
			if arity >= 0
				args = path_info.split('/', arity + 1)
				if args.length == arity
					[args, '']
				elsif args.length == arity + 1
					[args, args.pop]
				else
					[nil, path_info]
				end
			else
				args = path_info.split('/')
				if args.length >= arity.abs - 1
					[args, '']
				else
					[nil, path_info]
				end
			end
		end
		
	end
	
	def self.method_controller(*modules, &block)
		Class.new.tap do |controller|
			controller.instance_exec do
				include Mojito::Base
				include Mojito::Controllers::Method
				modules.each do |mod|
					include mod
				end
			end
			controller.class_exec &block if block
		end
	end
	
end