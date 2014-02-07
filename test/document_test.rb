require 'test_helper.rb'

#
# TestClass for Documents
#
# @author [benny]
#
class DocumentTest < Test::Unit::TestCase
  def setup
    @document = Rack::Blogengine::Document.new

    @document.title = 'testtitle'
    @document.path = '/test'
    @document.date = '20-20-2014'
    @document.html = '<html><h1>Test</h1></html>'
  end

  def test_document_has_content
    assert_equal('testtitle', @document.title, 'Document should contain the testtitle')
    assert_equal('/test', @document.path, 'Document should contain the test path')
    assert_equal('20-20-2014', @document.date, 'Document should contain the test date')
    assert_equal('<html><h1>Test</h1></html>', @document.html, 'Document should contain the test html')
  end

  def test_document_to_hash
    hashed = @document.to_hash

    assert_true(hashed.key?(:path), 'Hashed Document should contain the path')
    assert_true(hashed.key?(:html), 'Hashed Document should contain parsed html')
  end
end
