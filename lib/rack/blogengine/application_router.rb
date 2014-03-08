module Rack
  module Blogengine
    #
    # ApplicationRouter routes the request to the proper, parsed .content (layout.html + .content) file
    #
    # @author [benny]
    #
    module ApplicationRouter
      class << self
        # Maps documents to routes.
        # @param [Rack::Request] request [Current Request Object]
        # @param [Array] documents [parsed in Documents]
        # @return [Hash] request [route Hash {'path' => [String], 'response' => [Rack::Response]}]
        def map_route(request, documents)
          header = { 'Content-Type' => 'text/html; charset=UTF-8' }

          # Iterate through available docs, if nothing matched return nil
          documents.each do |doc|
            if doc[:path] == request.path
              response = Rack::Response.new(doc[:html], 200, header)

              route_response = {
                'path' => request.path,
                'response' => response
                # 'response' => [200, header, [doc[:html]]]
              }

              return route_response
            end
          end

          # if no document matches -> return error page
          errorpage(request, documents)
        end

        # Returns the errorpage
        # @param [Rack::Request] request [current Request]
        # @param [Array] documents [parsed in Documents]
        def errorpage(request, documents)
          header = { 'Content-Type' => 'text/html; charset=UTF-8' }
          response = Rack::Response.new('Page not found', 404, header)

          { 'path' => request.path, 'response' => response }
        end

        private :errorpage
      end
    end
  end
end
