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
end

# Previous content of test helper now starts here

# Minitest
require 'minitest/autorun'
# require 'minitest/pride' # for colored output
# require 'test_notifier/runner/minitest' # for a notifier

# TestUnit -> MiniTest (TestUnit is only compatibility Layer)
# require 'test/unit'

# Load Rack::Blogengine gem
require 'rack/blogengine'

# class Hash
  # method for usage with assert_boolean
  # -> for failing it needs nil instead of false (which #has_key? returns in failing case)
  # NOT Needed use assert_true instead...
  # def hash_key?(key)
  #   if self.has_key?(key)
  #	    return true
  #	  else
  #	    return nil
  #	  end
  # end
# end

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
