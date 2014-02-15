require 'test_helper'

#
# Test Class for DocumentParser
#
# @author [benny]
#
class DocumentParserTest < MiniTest::Unit::TestCase
  #parallelize_me!

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
  def test_fill_file_contents
    layout_file = ::File.open("#{testpath}/assets/layout/layout.html", 'r')
    layout = layout_file.read
    title = 'testtitle'
    content = 'testcontent'
    date = Date.new

    html = Rack::Blogengine::DocumentParser.fill_file_contents(layout, title, content, date)

    assert(html.include?(title), 'Parsed and filled in HTML should contain Title')
    assert(html.include?(content), 'Parsed and filled in HTML should contain Content')
    assert(html.include?(date.strftime('%d.%m.%Y')), 'Parsed and filled in HTML should contain Date')
  end

  def test_get_file_contents
    Rack::Blogengine::DocumentParser.title = ''
    Rack::Blogengine::DocumentParser.content = ''
    Rack::Blogengine::DocumentParser.date = ''

    Rack::Blogengine::DocumentParser.get_file_contents('index.content')

    assert_equal('INDEX', Rack::Blogengine::DocumentParser.title, 'Parsed in Title should eql Title in test .content file')
    assert_equal('<h2>This is the Index Page</h2>', Rack::Blogengine::DocumentParser.content, 'Parsed in Content should eql Content in test .content file')
    assert_instance_of(Date, Rack::Blogengine::DocumentParser.date, 'Parsed in Date should be of Class Date')
  end

  def test_get_content_array
    content = "[path]:[/path]
               [title]:INDEX[/title]
               [date]:2013,01,01[/date]
               [content]:
               <h2>This is the Index Page</h2>
               [/content]"
    contentarray = Rack::Blogengine::DocumentParser.get_content_array(content)

    assert_equal(4, contentarray.length, "The content Array should contain 4 members (Path, Title, Date, Content)")
    assert(contentarray[0].include?("path"), "First Entry should contain the path")
    assert(contentarray[1].include?("title"), "Second Entry should contain the title")
    assert(contentarray[2].include?("date"), "Third Entry should contain the date")
    assert(contentarray[3].include?("content"), "Fourth Entry should contain the content")
  end

  def teardown
    system("rm -rf #{testpath}")
  end
end
