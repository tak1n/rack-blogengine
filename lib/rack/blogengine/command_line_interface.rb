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
          print "\t #{method}\n" unless method == :method_missing || method == :setup
        end
        print "\n"
      end

      # Method to run the rack Application
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
        setup("operator.rb", "#{folder}/operator", true)

        # SET UP config.yml
        setup("config.yml", "#{folder}", true)

        # SET UP index.content
        setup("index.content", "#{folder}", true)

        # SET UP layout.html
        setup("layout.html", "#{folder}/assets/layout", true)

        # SET UP style.css
        setup("style.css", "#{folder}/assets/style", false)

        # SET UP script.js
        setup("script.js", "#{folder}/assets/js", false)

        puts "\n\tSetup finished! Have Fun\n"
        puts "\tTo test it type rack-blogengine run #{folder}"
      end

      # Helper method for generate to set up all essential files
      # param [String] name
      # param [String] path
      # param [boolean] essential
      def setup(name, path, essential)
        puts "\tSet up #{path}/#{name}\n"
        system("touch #{path}/#{name}")
        if essential
          content = IO.read("#{::File.dirname(__FILE__)}/files/#{name}")
          ::File.open("#{path}/#{name}", 'w') { |file| file.write(content) }
        end
      end

      # Display Version
      # return [String] VERSION
      def version?
        puts Rack::Blogengine::VERSION
      end
    end
  end
end