module Rack
  module Blogengine
    # 
    # ApplicationRouter routes the request to the proper, parsed .content (layout.html + .content) file
    # 
    # @author [benny]
    # 
    class ApplicationRouter
      # Maps documents to routes.
      # @param env Env Contains path info etc...
      # @param target Target folder
      # @return [Hash] route Hash {:path => "/foo", :response => [Array]}
      def self.map_route(env, target)
        status = 200
        header = {"Content-Type" => "text/html; charset=UTF-8"}
        path = env["PATH_INFO"]

        # TODO: dont parse all docs on every request -> doc cache (maybe parse at rack-blogengine run)
        # for fasten up accessing eg contentoperator in layout.html which has faraday request -> too big load times on every request!!!
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