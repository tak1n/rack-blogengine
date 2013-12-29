module Rack
  module Blogengine
    class ApplicationRouter

      # Maps documents to routes.
      # @param env Env Contains path info etc...
      # @param target Target folder
      # @return [Hash] route Hash {:path => "/foo", :response => [Array]}
      def self.map_route(env, target)
        status = 200
        header = {"Content-Type" => "text/html; charset=UTF-8"}
        path = env["PATH_INFO"]

        documents = DocParser.parseInDocuments(target)
       
           
        # Iterate through available docs, if nothing matched return nil
        # TODO: Dont iterate through every doc, get requested doc from DocParser
        # Operators should have access to ALL available docs (title, path, html etc)
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