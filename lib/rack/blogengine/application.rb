module Rack
  module Blogengine
    class Application
		def call(env) 
			route = ApplicationRouter.map_route(env) 
			if route  
				puts route
				return route["response"] 
			else 
				return [404, {"Content-Type" => "text/html"}, ["Page not found"]] 
			end 
		end                
    end
  end
end