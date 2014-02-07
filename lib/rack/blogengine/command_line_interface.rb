require 'rack'
require 'yaml'

module Rack
  module Blogengine
    #
    # This Class handles all cli input (running the app, generate folder skeleton)
    #
    # @author [benny]
    #
    class CommandLineInterface
      def method_missing(name, *args)
        puts "Command #{name} not available"
        print 'Available Commands are: \n\n'
        self.class.instance_methods(false).each do |method|
          print "\t #{method}\n" unless method == :method_missing # || method == :setup || method == :getConfig
        end
        print "\n"
      end

      # Method to run the rack Application
      # @param [String] target
      def run(target)
        if target.empty?
          puts 'Specify a targetfolder!'
        else
          if target.include?('/')
            target = target.dup
            target['/'] = ''
          end

          if Dir.exists?("#{target}")
            system("cd #{target}")

            targetfolder = "#{Dir.pwd}/#{target}"
            config = get_config(targetfolder)

            app = Rack::Builder.new do
              map '/assets' do
                run Rack::Directory.new("#{targetfolder}/assets")
              end

              use Rack::CommonLogger
              use Rack::ShowExceptions
              use Rack::Lint

              if config['Usage'] == 'yes'
                use Rack::Auth::Basic, 'Protected Area' do |username, password|
                  username == config['Username'] && password == config['Password']
                end
              end

              # Parse in all Documents in cli.run(target)
              # -> $documents are parsed in only once and then cached via a global variable
              $documents = DocParser.parseInDocuments(targetfolder)

              run Rack::Blogengine::Application
            end

            Rack::Server.start(app: app, Port: config['Port'], server: config['Server'])
          else
            puts 'Target is not a folder!'
          end
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
        setup('operator.rb', "#{folder}/operator", true)

        # SET UP config.yml
        setup('config.yml', "#{folder}", true)

        # SET UP index.content
        setup('index.content', "#{folder}", true)

        # SET UP layout.html
        setup('layout.html', "#{folder}/assets/layout", true)

        # SET UP style.css
        setup('style.css', "#{folder}/assets/style", false)

        # SET UP script.js
        setup('script.js', "#{folder}/assets/js", false)

        puts "\n\tSetup finished! Have Fun\n"
        puts "\tTo test it type rack-blogengine run #{folder}"
      end

      # Display Version
      # return [String] VERSION
      def version?
        puts "\n\tVERSION: #{Rack::Blogengine::VERSION}"
        puts "\tRack::Blogengine releases are all pre-relases, first production release will be VERSION 1.0.0\n\n"
      end

      private

      # Helper method for generate to set up all essential files
      # param [String] name
      # param [String] path
      # param [boolean] essential
      def setup(name, path, essential)
        puts "\tSet up #{path}/#{name}\n"
        system("touch #{path}/#{name}")
        if essential
          assetspath = "#{Rack::Blogengine.root}/assets/#{name}"
          content = IO.read(assetspath)
          ::File.open("#{path}/#{name}", 'w') { |file| file.write(content) }
        end
      end

      # Get YAML Config settings for Server.start && HTTPauth
      def get_config(target)
        config_yaml = YAML.load(::File.open("#{target}/config.yml"))

        port = config_yaml['Port']
        server = config_yaml['Server']
        username = config_yaml['HTTPauth']['username'].to_s.strip
        password = config_yaml['HTTPauth']['password'].to_s.strip
        usage = config_yaml['HTTPauth']['usage']

        { 'Port' => port, 'Server' => server, 'Username' => username, 'Password' => password, 'Usage' => usage }
      end
    end
  end
end
