require 'test_helper.rb'

#
# TestClass for CommandLineInterface
#
# @author [benny]
#
class CommandLineInterfaceTest < MiniTest::Unit::TestCase
  def setup
  	@cli = Rack::Blogengine::CommandLineInterface.new
  end

  def test_available_methods
    assert(@cli.respond_to?(:method_missing), 'CLI should respond to :method_missing method')
  	assert(@cli.respond_to?(:run), 'CLI should respond to :run method')
  	assert(@cli.respond_to?(:generate), 'CLI should respond to :generate method')
  	assert(@cli.respond_to?(:version?), 'CLI should respond to :version? method')
  end

  def test_methods_missing
  	result = capture_stdout { @cli.send(:missing_method) }
  	assert(result.include?('Command missing_method not available'), 'Not Available Method should not raise NoMethodError')
  end

  def test_version?
  	result = capture_stdout { @cli.send(:version?) }
  	assert(result.include?('VERSION'), ':version? should output the current VERSION')
  end

  def test_generate
  	capture_stdout { @cli.send(:generate, testpath) }

  	assert(Dir.exist?(testpath), 'Test Directory should exist after generate method')
  	assert(Dir.exist?("#{testpath}/assets"), 'assets Directory should exist after generate method')
  	assert(Dir.exist?("#{testpath}/assets/layout"), 'assets/layout Directory should exist after generate method')
  	assert(Dir.exist?("#{testpath}/assets/style"), 'assets/style Directory should exist after generate method')
  	assert(Dir.exist?("#{testpath}/assets/js"), 'assets/js Directory should exist after generate method')
  	assert(Dir.exist?("#{testpath}/assets/images"), 'assets/images Directory should exist after generate method')
  	assert(Dir.exist?("#{testpath}/operator"), 'operator Directory should exist after generate method')
  	
  	assert(File.exist?("#{testpath}/operator/operator.rb"), 'operator.rb should exist after generate method')
  	assert(File.exist?("#{testpath}/config.yml"), 'config.yml should exist after generate method')
  	assert(File.exist?("#{testpath}/index.content"), 'index.content should exist after generate method')
  	assert(File.exist?("#{testpath}/assets/layout/layout.html"), 'layout.html should exist after generate method')
  	assert(File.exist?("#{testpath}/assets/style/style.css"), 'style.css should exist after generate method')
  	assert(File.exist?("#{testpath}/assets/js/script.js"), 'script.js should exist after generate method')
  	
  	system("rm -rf #{testpath}")
  end

  def test_run_empty_string_argument
  	result = capture_stdout { @cli.send(:run, "") }
  	assert_equal('Specify a targetfolder!', result, 'run method should output "Specify a targetfolder!" when folderstring is empty')
  end

  def test_run_not_folder_string_argument
  	result = capture_stdout { @cli.send(:run, "not_a_directory") }
  	assert_equal('Target is not a folder!', result, 'run method should output "Target is not a folder!" when folderstring is not pointing to a directory')
  end

  # test_run is handled via cucumber feature test
  #def test_run
  	#capture_stdout { @cli.send(:generate, testpath) }

  	#system("cd #{testpath} && cd ..")
  	#testpatharray = testpath.split("/")
  	#result = capture_stdout { @cli.send(:run, testpatharray.pop) }

  	#system("pkill -9 rack-blogengine && pkill -9 ruby")
  	#system("rm -rf #{testpath}")
  #end
end