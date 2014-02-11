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

    @documents = Rack::Blogengine::DocumentParser.parse_in_documents(testpath)
  end

  def test_parse_in_documents
    @documents.each do |document|
      # Check Hash keys
      assert(document.key?(:html), 'Documents should contain a path')
      assert(document.key?(:path), 'Documents should contain a response')
    end
  end

  # Single Test method for each class method in document_parser.rb ?
  # parse_in_documents calls other class methods so when something is wrong with other class method
  # test_parse_in_documents will fail => so for now only 1 test here

  def teardown
    system("rm -rf #{testpath}")
  end
end
