require 'rack/blogengine/version'
require 'rack/blogengine/document_parser'
require 'rack/blogengine/document'
require 'rack/blogengine/application'
require 'rack/blogengine/application_router'
require 'rack/blogengine/command_line_interface'
require 'rack/blogengine/operator'

# require third party libaries
require 'pathname'
require 'pygments'
require 'nokogiri'

module Rack
  #
  # BlogEngine Module used for namespacing
  # @author [benny]
  #
  module Blogengine
    class << self
      attr_accessor :documents, :config

      # Method to return Gem Root Dir
      # @return [String] Gem Root Folder
      def root
        ::File.dirname(::File.dirname(::File.expand_path('..', __FILE__)))
      end
    end
  end
end
