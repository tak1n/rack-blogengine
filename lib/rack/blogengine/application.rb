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
      # @param env Environment contains information such as path, headers etc...
      # @return [Array] response Array
      def self.call(env)
        # Router for map docs to routes
        route = ApplicationRouter.map_route(env, $targetfolder) 
        if route  
          return route["response"] 
        else
          #TODO Errorpage handling
          return [404, {"Content-Type" => "text/html; charset=UTF-8"}, ["Page not found"]] 
        end 
      end                
    end
  end
end