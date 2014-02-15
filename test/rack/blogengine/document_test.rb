require 'test_helper.rb'

#
# TestClass for Documents
#
# @author [benny]
#
class DocumentTest < MiniTest::Unit::TestCase
  # parallelize_me!() # Run Tests parallel
  # Nice comment: In doing so, you’re admitting that you rule and your tests are awesome.

  def setup
    @document = Rack::Blogengine::Document.new

    @document.title = 'testtitle'
    @document.path = '/test'
    @document.date = '20-20-2014'
    @document.html = '<html><h1>Test</h1></html>'
  end

  def test_new_document
    assert_instance_of(Rack::Blogengine::Document, @document, 'Document should be of class Rack::Blogengine::Document')
  end

  def test_document_has_content
    assert_equal('testtitle', @document.title, 'Document should contain the testtitle')
    assert_equal('/test', @document.path, 'Document should contain the test path')
    assert_equal('20-20-2014', @document.date, 'Document should contain the test date')
    assert_equal('<html><h1>Test</h1></html>', @document.html, 'Document should contain the test html')
  end

  def test_document_to_hash
    hashed = @document.to_hash
    assert(hashed.key?(:path), 'Hashed Document should contain the path')
    assert(hashed.key?(:html), 'Hashed Document should contain parsed html')
  end

  def test_exec_content_operator
    cli = Rack::Blogengine::CommandLineInterface.new
    capture_stdout { cli.generate(testpath) }

    document = Rack::Blogengine::Document.new
    document.html = "{% test_operator %}"
    
    document.exec_content_operator(document, testpath)
    
    assert_equal("test", document.html, 'Documents html should contain test_operators return value')

    system("rm -rf #{testpath}")
  end
end
