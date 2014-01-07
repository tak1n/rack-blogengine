require 'rack'
#require 'rack/attack'
require 'rack/blogengine'

module Rack
  module Blogengine
    class CommandLineInterface
      def method_missing(name, *args)
        puts "Command #{name} not available"
        print "Available Commands are: \n\n"
        self.class.instance_methods(false).each do |method|
          print "\t #{method}\n" unless method == :method_missing
        end
        print "\n"
      end

      # Method to run the cli command
      # @param [String] target
      def run(target)
        unless target.empty?
          if target.include?("/") 
              target = target.dup
              target["/"] = ""
          end

          if Dir.exists?("#{target}")
            system("cd #{target}")
            $targetfolder = "#{Dir.pwd}/#{target}"
            app = Rack::Builder.new do
              use Rack::CommonLogger
              use Rack::ShowExceptions

              map "/assets" do
                run Rack::Directory.new("#{$targetfolder}/assets")
              end
              use Rack::Lint
              run Rack::Blogengine::Application
            end

            Rack::Server.start( :app => app, :Port => 3000 )
          else
            puts "Target is not a folder!"
          end
        else 
          puts "Specify a targetfolder!"
        end
      end

      # Command to generate the folder skeleton
      # @param [String] folder
      def generate(folder)
        puts "Generating folder skeleton"
        system("mkdir #{folder} && mkdir #{folder}/assets && mkdir #{folder}/assets/layout && mkdir #{folder}/assets/js && mkdir #{folder}/assets/style && mkdir #{folder}/assets/images")
      end
    end
  end
end