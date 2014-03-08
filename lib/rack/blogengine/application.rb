module Rack
  module Blogengine
    #
    # Application is the callable middleware class
    # run Rack::Blogengine::Application
    #
    # @author [benny]
    #
    class Application
      # Call Method for run this method as Rack Middleware.
      # @param [Hash] env [Environment contains information such as path, headers etc...]
      # @return [Rack::Response] Rack Response
      def call(env)
        request = Rack::Request.new(env)

        # Router for map docs to routes
        route = ApplicationRouter.map_route(request, Rack::Blogengine.documents)

        route['response'].finish
      end
    end
  end
end
