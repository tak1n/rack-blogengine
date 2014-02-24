module Rack
  module Blogengine
    #
    # ApplicationRouter routes the request to the proper, parsed .content (layout.html + .content) file
    #
    # @author [benny]
    #
    module ApplicationRouter
      # Maps documents to routes.
      # @param env Env Contains path info etc...
      # @param documents Documents which will be looked at
      # @return [Hash] route Hash {:path => "/foo", :response => [Array]}
      class << self
        def map_route(env, documents)
          success_status = 200
          header = { 'Content-Type' => 'text/html; charset=UTF-8' }
          path = env['PATH_INFO']

          # Iterate through available docs, if nothing matched return nil
          documents.each do |doc|
            if doc[:path] == path
              route_response = {
                'path' => path,
                'response' => [success_status, header, [doc[:html]]]
              }

              return route_response
            end
          end

          # if no document matches -> return error page
          errorpage(env, documents)
        end

        def errorpage(env, documents)
          { 'path' => env['PATH_INFO'],
            'response' =>
            [404, { 'Content-Type' => 'text/html; charset=UTF-8' }, ['Page not found']]
          }
        end
      end
    end
  end
end
