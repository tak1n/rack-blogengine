require 'test_helper.rb'

#
# TestClass for ApplicationRouter
#
# @author [benny]
#
class ApplicationTest < Minitest::Test
  include Rack::Test::Methods

  def app
    Rack::Blogengine::Application.new
  end

  def setup
    @cli = Rack::Blogengine::CommandLineInterface
    capture_stdout { @cli.generate(testpath) }
    Rack::Blogengine.config = @cli.send(:get_config, testpath)
    Rack::Blogengine.documents = Rack::Blogengine::DocumentParser.parse_in_documents(testpath)
  end

  def test_application_is_callable
    get '/'

    assert(last_response.body.include?('This is the Index Page'))
  end

  def teardown
    system("rm -rf #{testpath}")
  end
end
