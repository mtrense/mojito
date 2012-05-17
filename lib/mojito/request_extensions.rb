# encoding: UTF-8

class ::Rack::Request
	
	def captures
		@env['mojito/captures'] ||= []
	end
	
	def locals
		@env['mojito/locals'] ||= Mash.new
	end
	
	def script_name
		@env['SCRIPT_NAME']
	end
	
	def path_info
		@env['PATH_INFO']
	end
	
end