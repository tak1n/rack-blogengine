module Rack
  module Blogengine
    def self.root
      ::File.dirname(::File.expand_path('../..',__FILE__))
    end
  end
end