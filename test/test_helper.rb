# Minitest
require 'minitest/unit'
require 'minitest/autorun'
# require 'minitest/pride' # for colored output
# require "test_notifier/runner/minitest" for a notifier

# TestUnit -> MiniTest (TestUnit is only compatibility Layer)
# require 'test/unit'

# Load Rack::Blogengine && Rack::Test
require 'rack/blogengine'
require 'rack/test'

# alternative to require_relative
# rake install in gem dir and then
# require 'mygem'

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
