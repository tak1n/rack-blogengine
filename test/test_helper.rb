require "codeclimate-test-reporter"
CodeClimate::TestReporter.start

require 'minitest/autorun'
require 'minitest/reporters'

Minitest::Reporters.use!(
  Minitest::Reporters::SpecReporter.new,
  ENV,
  Minitest.backtrace_filter
)

# Rack Test Methods
require 'rack/test'

# Load Rack::Blogengine gem
require 'rack/blogengine'

#
# Opening Kernel for testpath method
#
# @author [benny]
#
module Kernel
  def testpath
    "#{Rack::Blogengine.root}/testfolder"
  end
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
