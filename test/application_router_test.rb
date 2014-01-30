require_relative 'test_helper.rb'

class ApplicationRouterTest < Test::Unit::TestCase
  def setup
  	puts "\n Class: #{self.class.superclass}"
  end

  def test_map_route
  	omit("Pending")
  end

  def teardown
  	puts Rack::Blogengine.root
    system("rm -rf #{Rack::Blogengine.root}/testfolder")
  end
end