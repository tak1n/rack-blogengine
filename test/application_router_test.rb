require 'test_helper.rb'

class ApplicationRouterTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def setup
    cli = Rack::Blogengine::CommandLineInterface.new
    capture_stdout { cli.generate(testpath) }

    documents = Rack::Blogengine::DocParser.parseInDocuments(testpath)
    env_fail = { "PATH_INFO" => "/fail" }
    env_success = { "PATH_INFO" => "/" }

    @route_success = Rack::Blogengine::ApplicationRouter.map_route(env_success, documents)
    @route_fail = Rack::Blogengine::ApplicationRouter.map_route(env_fail, documents)
  end

  def test_map_route_general
    assert_equal( Hash, @route_success.class, "Route should be a hash")

    # Check Hash keys
    assert_true(@route_success.has_key?("path"), "Route should contain a path")
    assert_true(@route_success.has_key?("response"), "Route should contain a response")

    # Check path
    assert_equal( String, @route_success["path"].class, "Path should be a string")

    # Check response
    assert_equal( Array, @route_success["response"].class, "Response should be an Array")

    
    assert_equal( Fixnum, @route_success["response"][0].class, "Status should be a Fixnum")
  end

  def test_map_route_on_success
    assert_equal(  200, @route_success["response"][0], "Status should be 200")
  end

  def test_map_route_on_fail
    assert_equal(  404, @route_fail["response"][0], "Status should be 404")
  end

  def teardown
    system("rm -rf #{testpath}")
  end
end