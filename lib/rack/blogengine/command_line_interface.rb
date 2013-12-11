require 'rack'
require 'rack/blogengine'

module Rack
  module Blogengine
    class CommandLineInterface
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
    end
  end
end