require 'test_helper'

#
# Test Class for DocumentParser
#
# @author [benny]
#
class DocumentParserTest < Minitest::Test
  def setup
    @cli = Rack::Blogengine::CommandLineInterface
    capture_stdout { @cli.generate(testpath) }
    @cli.send(:get_config, testpath)
  end

  def test_parse_in_documents
    documents = Rack::Blogengine::DocumentParser.parse_in_documents(testpath)

    documents.each do |document|
      # Check Hash keys
      assert(document.key?(:html), 'Documents should contain content')
      assert(document.key?(:path), 'Documents should contain a path')
    end
  end

  def test_invalid_date
    system("rm #{testpath}/index.content")
    capture_stdout { @cli.send(:setup, 'date_error.content', "#{testpath}", true) }
    assert_raises(RuntimeError) { Rack::Blogengine::DocumentParser.parse_in_documents(testpath) }
  end

  def test_invalid_content
    system("rm #{testpath}/index.content")
    capture_stdout { @cli.send(:setup, 'content_error.content', "#{testpath}", true) }
    assert_raises(RuntimeError) { Rack::Blogengine::DocumentParser.parse_in_documents(testpath) }
  end

  def test_invalid_title
    system("rm #{testpath}/index.content")
    capture_stdout { @cli.send(:setup, 'title_error.content', "#{testpath}", true) }
    assert_raises(RuntimeError) { Rack::Blogengine::DocumentParser.parse_in_documents(testpath) }
  end

  def test_documents_with_pygments
    capture_stdout { @cli.send(:setup, 'pygment.content', "#{testpath}", true) }
    system("rm #{testpath}/index.content")
    documents = Rack::Blogengine::DocumentParser.parse_in_documents(testpath)
    documents.each do |document|
      assert(document[:html].include?('class="highlight"'), 'Highlighted code should be wrapped in a div.highlight')
    end
  end

  def test_documents_with_operator
    capture_stdout { @cli.send(:setup, 'operator.content', "#{testpath}", true) }
    system("rm #{testpath}/index.content")
    documents = Rack::Blogengine::DocumentParser.parse_in_documents(testpath)
    documents.each do |document|
      assert(document[:html].include?('test'), 'Test Operator should return test')
    end
  end

  def test_document_sort
    capture_stdout { @cli.send(:setup, 'date_test.content', "#{testpath}", true) }
    documents = Rack::Blogengine::DocumentParser.parse_in_documents(testpath)
    assert(documents[0][:html].include?('This is 2012'), 'The Document with lower date should be first')
  end

  def teardown
    system("rm -rf #{testpath}")
  end
end
