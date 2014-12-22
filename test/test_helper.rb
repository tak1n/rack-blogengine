require 'simplecov'
require 'coveralls'

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[
  SimpleCov::Formatter::HTMLFormatter,
  Coveralls::SimpleCov::Formatter
]

SimpleCov.start do
  project_name 'rack-blogengine'
  add_filter '/test/'
  add_filter '/pkg/'
  add_filter '/spec/'
  add_filter '/features/'
  add_filter '/doc/'
  add_filter '/assets/'
end if ENV['COVERAGE']

gem 'minitest'
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
