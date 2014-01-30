# Minitest
#require 'minitest/autorun'
#require 'minitest/pride' # for colored output
#require "test_notifier/runner/minitest"

# Real TestUnit
require "test/unit/notify"
require 'test/unit'


require_relative '../lib/rack/blogengine.rb'
# alternative to require_relative
# rake install in gem dir and then
# require 'mygem'
