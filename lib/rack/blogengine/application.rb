module Rack
  module Blogengine
    class Application              
	  def call(env)
	    request = Rack::Request.new(env)
	    headers = { 'Content-Type' => 'text/html' }

	    case request.path
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