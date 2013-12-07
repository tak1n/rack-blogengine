module Rack
  module Blogengine
    class Application
      def initialize(doc)
        @doc_html = doc[:html]
        @doc_path = doc[:path]
      end
                   
	  def call(env)

	    request = Rack::Request.new(env)
	    headers = { 'Content-Type' => 'text/html' }

	    #request.path to :path mapping
	    #docdummy.each do |doc|
	   		#if doc["path"] == request.path
	   			#[200, headers, [doc["html"]] ]
	   		#end
	   	#end	

	   	#if @found != true
	   	#	[404, headers, ["Uh oh, path not found!"]]
	   	#end
	   	#
	   	case request.path
	    when @doc_path
	      [200, headers, [@doc_html] ]
	    else
	      [404, headers, ["Uh oh, path not found!"]]
	   	end
  	   end                  
    end
  end
end