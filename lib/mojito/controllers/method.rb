# encoding: UTF-8

module Mojito::Controllers
	
	module Method
		
		def __dispatch
			%r{^/?(?<meth>\w+)(?:/(?<rest>.+))?$} =~ request.path_info
			if respond_to?(meth.to_sym)
				arity = method(meth.to_sym).arity
				args = rest ? rest.split('/') : []
				if arity == args.length or arity < 0 and (-arity - 1) < args.length
					send meth.to_sym, *args
				else
					Mojito::R::StatusCodes.instance_method(:not_found!).bind(self).call
				end
			else
				Mojito::R::StatusCodes.instance_method(:not_found!).bind(self).call
			end
		end
		
	end
	
	def self.method_controller(&block)
		Class.new.tap do |controller|
			controller.instance_exec do
				include Mojito::Base
				include Mojito::Controllers::Method
			end
			controller.class_exec &block if block
		end
	end
	
end