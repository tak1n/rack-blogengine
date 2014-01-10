require 'rack'
require 'rack/blogengine'
require 'yaml'

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
            config = YAML::load(::File.open("#{$targetfolder}/config.yml"))
            app = Rack::Builder.new do
              use Rack::CommonLogger
              use Rack::ShowExceptions

              map "/assets" do
                run Rack::Directory.new("#{$targetfolder}/assets")
              end
              use Rack::Lint
              run Rack::Blogengine::Application
            end

            
            port = config["Port"];
            server = config["Server"];
            Rack::Server.start( :app => app, :Port => port, :server => server )
          else
            puts "Target is not a folder!"
          end
        else 
          puts "Specify a targetfolder!"
        end
      end

      # Command to generate the folder skeleton
      # @param [String] folder
      # TODO: refactor this - similar functions for each set up set => outsource to a method setup()
      def generate(folder)
        puts "\tGenerating folder skeleton\n"
        system("mkdir #{folder}")
        system("mkdir #{folder}/assets")
        system("mkdir #{folder}/assets/layout")
        system("mkdir #{folder}/assets/js")
        system("mkdir #{folder}/assets/style")
        system("mkdir #{folder}/assets/images")
        system("mkdir #{folder}/operator")

        puts "\n\tSetting up essential Files\n"

        # SET UP operator.rb
        puts "\tSet up #{folder}/operator/operator.rb\n"
        system("touch #{folder}/operator/operator.rb")
        content = IO.read("#{::File.dirname(__FILE__)}/files/operator.rb")
        ::File.open("#{folder}/operator/operator.rb", 'w') { |file| file.write(content) }

        # SET UP config.yml
        puts "\tSet up config.yml\n"
        system("touch #{folder}/config.yml")
        content = IO.read("#{::File.dirname(__FILE__)}/files/config.yml")
        ::File.open("#{folder}/config.yml", 'w') { |file| file.write(content) }

        # SET UP index.content
        puts "\tSet up #{folder}/index.content\n"
        system("touch #{folder}/index.content")
        content = IO.read("#{::File.dirname(__FILE__)}/files/index.content")
        ::File.open("#{folder}/index.content", 'w') { |file| file.write(content) }

        # SET UP layout.html
        puts "\tSet up #{folder}/assets/layout/layout.html\n"
        system("touch #{folder}/assets/layout/layout.html")
        content = IO.read("#{::File.dirname(__FILE__)}/files/layout.html")
        ::File.open("#{folder}/assets/layout/layout.html", 'w') { |file| file.write(content) }

        # SET UP style.css
        puts "\tSet up #{folder}/assets/style/style.css\n"
        system("touch #{folder}/assets/style/style.css")

        # SET UP style.css
        puts "\tSet up #{folder}/assets/js/script.js\n"
        system("touch #{folder}/assets/js/script.js")

        puts "\n\tSetup finished! Have Fun\n"
        puts "\tTo test it type rack-blogengine run #{folder}"
      end

      # Display Version
      # return [String] VERSION
      def version?
        puts Rack::Blogengine::VERSION
      end
    end
  end
end