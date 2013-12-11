require 'rack'
require 'rack/blogengine'

module Rack
  module Blogengine
    class CommandLineInterface
    	# Method to run the cli command
    	# @param [String] target
    	def run(target)
    	  unless target.empty? 
            $targetfolder = target
            app = Rack::Builder.new do
              use Rack::CommonLogger
              use Rack::ShowExceptions

              map "/assets" do
                run Rack::Directory.new("#{$targetfolder}/assets")
              end

              use Rack::Lint
              run Rack::Blogengine::Application
            end

            Rack::Server.start( :app => app )
          else 
            puts "Specify a targetfolder!"
          end
    	end

    	# TODO write generate method to generate blog skeleton (assets, layout etc)
    	def generate(folder)
    	end
    end
  end
end