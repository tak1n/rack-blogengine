module Rack
  #
  # BlogEngine Module used for namespacing
  # Used in all /lib files
  #
  # @author [benny]
  #
  module Blogengine
    def self.root
      ::File.dirname(::File.dirname(::File.expand_path('../..', __FILE__)))
    end
  end
end
