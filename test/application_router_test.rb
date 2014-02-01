require 'test_helper.rb'

class ApplicationRouterTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def setup
  	documents = Rack::Blogengine::DocParser.parseInDocuments(testpath)
    env_fail = { "PATH_INFO" => "/fail" }
    env_success = { "PATH_INFO" => "/" }

    @route = Rack::Blogengine::ApplicationRouter.map_route(env_success, documents)
  end

  def test_map_route_general
    assert_equal( Hash, @route.class, "Route should be a hash")

    # Check Hash keys
    assert_true(@route.has_key?("path"), "Route should contain a path")
    assert_true(@route.has_key?("response"), "Route should contain a response")

    # Check path
    assert_equal( String, @route["path"].class, "Path should be a string")

    # Check response
    assert_equal( Array, @route["response"].class, "Response should be an Array")

    
    assert_equal( Fixnum, @route["response"][0].class, "Status should be a Fixnum")
  end

  def test_map_route_on_success
    assert_equal( 200, @route["response"][0], "Status should be 200")
  end

  def teardown
    #system("rm -rf #{testpath}")
  end
end