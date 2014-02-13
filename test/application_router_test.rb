require 'test_helper.rb'

#
# TestClass for ApplicationRouter
#
# @author [benny]
#
class ApplicationRouterTest < MiniTest::Unit::TestCase
  parallelize_me!()
  
  def setup
    # fake document
    documents = [{ html: '<!DOCTYPE html><body><h2>This is the Index Page</h2></body></html>',
                   path: '/' }]

    env_fail = { 'PATH_INFO' => '/fail' }
    env_success = { 'PATH_INFO' => '/' }

    @route_success = Rack::Blogengine::ApplicationRouter.map_route(env_success, documents)
    @route_fail = Rack::Blogengine::ApplicationRouter.map_route(env_fail, documents)
  end

  def test_map_route_general
    assert_instance_of(Hash, @route_success, 'Route should be a hash')

    # Check Hash keys
    assert(@route_success.key?('path'), 'Route should contain a path')
    assert(@route_success.key?('response'), 'Route should contain a response')

    # Check path
    assert_instance_of(String, @route_success['path'], 'Path should be a string')

    # Check response
    assert_instance_of(Array, @route_success['response'], 'Response should be an Array')
    assert_instance_of(Fixnum, @route_success['response'][0], 'Status should be a Fixnum')
  end

  def test_map_route_on_success
    assert_equal(200, @route_success['response'][0], 'Status should be 200')
  end

  def test_map_route_on_fail
    assert_equal(404, @route_fail['response'][0], 'Status should be 404')
  end

  def teardown
  end
end
