module Rack
	module Blogengine
		class ApplicationResponse
			def self.call
				res = Rack::Response.new
 
			    # This will automatically set the Content-Length header for you
			    res.write "Hello from Rack!"
			 
			    # returns the standard [status, headers, body] array
			    res.finish
			end	
		end
	end
end