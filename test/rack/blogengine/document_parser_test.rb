require 'test_helper'

#
# Test Class for DocumentParser
#
# @author [benny]
#
class DocumentParserTest < MiniTest::Unit::TestCase
  def setup
    cli = Rack::Blogengine::CommandLineInterface.new
    capture_stdout { cli.generate(testpath) }
    cli.send(:get_config, testpath)
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
    skip
  end

  def test_invalid_content
    skip
  end

  def test_invalid_title
    skip
  end

  def test_documents_with_pygments
    skip
  end
    
  def teardown
    system("rm -rf #{testpath}")
  end
end
