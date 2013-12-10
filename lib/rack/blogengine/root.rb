module Rack
  module Blogengine
    class Root
      # Call Method for run this method as Rack Middleware.
      # @param env Environment contains information such as path, headers etc...
      # @return [Array] response Array
      def self.call(env)
        # get all documents
        documents = DocParser.parseInDocuments($targetfolder)
        puts documents
        if route  
          return route["response"] 
        else 
          return [404, {"Content-Type" => "text/html; charset=UTF-8"}, ["Page not found"]] 
        end 
      end                
    end
  end
end