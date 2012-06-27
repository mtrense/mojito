# encoding: UTF-8

module Mojito::Controllers
	
	module Method
		
		def __dispatch
			%r{^/?(?<meth>\w+)(?:/(?<rest>.+))?$} =~ request.path_info
			if respond_to?(meth.to_sym)
				
				send meth.to_sym
			else
				Mojito::R::StatusCodes.instance_method(:not_found!).bind(self).call
			end
		end
		
	end
	
end