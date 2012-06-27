# encoding: UTF-8

class ::Rack::Request
	
	def dup
		Rack::Request.new(@env.dup)
	end
	
	def captures
		@env['mojito/captures'] ||= []
	end
	
	def locals
		@env['mojito/locals'] ||= Mash.new
	end
	
	def context_path
		@env['MOJITO/CONTEXT_PATH']
	end
	
	def script_name
		@env['SCRIPT_NAME']
	end
	
	def path_info
		@env['PATH_INFO']
	end
	
	get_method = instance_method(:GET)
	define_method :GET do
		get_method.bind(self).call.to_mash
	end
	
	post_method = instance_method(:POST)
	define_method :POST do
		post_method.bind(self).call.to_mash
	end

end