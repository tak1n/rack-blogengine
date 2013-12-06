module Rack
  module Blogengine
    class Application
      def initialize(app)
        @app = app
      end
                   
	  def call(env)

	    request = Rack::Request.new(env)
	    headers = { 'Content-Type' => 'text/html' }

	    case request.path
	    	#TODO map requests with available docs from docparser
	    when '/'
	      [200, headers, ["You're at the root url!"]]
	    when '/foo'
	      [200, headers, ["You're at /foo!"]]
	    else
	      [404, headers, ["Uh oh, path not found!"]]
	    end
  	   end                  
    end
  end
end