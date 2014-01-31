require 'test_helper.rb'

class ApplicationRouterTest < Test::Unit::TestCase
  def setup
  	puts "Path is: #{testpath}"
  	@document = Rack::Blogengine::DocParser.parseInDocuments(testpath)
  end

  def test_map_route
  	puts @document
  end

  def teardown
  	puts Rack::Blogengine.root
    system("rm -rf #{Rack::Blogengine.root}/testfolder")
  end
end