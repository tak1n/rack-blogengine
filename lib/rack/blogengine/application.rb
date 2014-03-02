module Rack
  module Blogengine
    #
    # Application is the callable middleware class
    # run Rack::Blogengine::Application
    #
    # @author [benny]
    #
    class Application
      # def initialize(app)
        # @app = app
      # end
      # Call Method for run this method as Rack Middleware.
      # @param env Environment contains information such as path, headers etc...
      # @return [Array] response Array
      def call(env)
        # Router for map docs to routes
        route = ApplicationRouter.map_route(env, Rack::Blogengine.documents)

        route['response']
      end
    end
  end
end
