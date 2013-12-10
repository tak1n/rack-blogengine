module Rack
  module Blogengine
    class ApplicationRouter 
    	def self.map_route(env, target)
    		status = 200
    		header = {"Content-Type" => "text/html; charset=UTF-8"}
    		path = env["PATH_INFO"]

    		documents = DocParser.parseInDocuments(target)
           
            # Iterate through available docs, if nothing matched return nil
    		documents.each do |doc|
    			if doc[:path] == path
    				route_response = {
    					"route" => path,
    					"response" => [status, header, [doc[:html]] ]
    				}

    				return route_response
    			end
    		end

            return nil
    	end
    end
  end
end