# Minitest
#require 'minitest/autorun'
#require 'minitest/pride' # for colored output
#require "test_notifier/runner/minitest"

# Real TestUnit
require 'test/unit'
require 'test/unit/notify'


require 'rack/blogengine'

# alternative to require_relative
# rake install in gem dir and then
# require 'mygem'

def testpath
 return "#{Rack::Blogengine.root}/testfolder"
end

def capture_stdout(&block)
  original_stdout = $stdout
  $stdout = fake = StringIO.new
  begin
    yield
  ensure
    $stdout = original_stdout
  end
  fake.string
end

cli = Rack::Blogengine::CommandLineInterface.new
capture_stdout { cli.generate(testpath) }