require "rack/blogengine/version"
require "rack/blogengine/doc_parser"
require "rack/blogengine/document"
require "rack/blogengine/application"
require "rack/blogengine/application_router"
require "rack/blogengine/operator"

module Rack
  module Blogengine
    def self.root
      ::File.dirname(::File.expand_path('../..',__FILE__))
    end
  end
end

