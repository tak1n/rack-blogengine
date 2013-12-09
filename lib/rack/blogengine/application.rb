module Rack
  module Blogengine
    class Application
    	def initialize(target)
    		@targetfolder = target
    	end

		def call(env) 
			route = ApplicationRouter.map_route(env, @targetfolder) 
			if route  
				return route["response"] 
			else 
				return [404, {"Content-Type" => "text/html"}, ["Page not found"]] 
			end 
		end                
    end
  end
end