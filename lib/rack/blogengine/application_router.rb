module Rack
  module Blogengine
    class ApplicationRouter 
    	def self.map_route(env, target)
    		status = 200
    		header = {"Content-Type" => "text/html"}
    		path = env["PATH_INFO"]

    		#TODO: Replace docdummy with parsed docs from docparser
    		#docdummy = [{ path: "/foo", html: "<h1>FooHi</h1>"}]
    		documents = DocParser.parseInDocuments(target)

    		documents.each do |doc|
    			if doc[:path] == path

    				route_response = {
    					"route" => path,
    					"response" => [status, header, [doc[:html]] ]
    				}

    				return route_response
    			end

    			return nil
    		end
    	end
    end
  end
end