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
    @documents = Rack::Blogengine::DocumentParser.parse_in_documents(testpath)

    @documents.each do |document|
      # Check Hash keys
      assert(document.key?(:html), 'Documents should contain a path')
      assert(document.key?(:path), 'Documents should contain a response')
    end
  end

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

  def test_fill_file_contents_with_pygments
    layout_file = ::File.open("#{testpath}/assets/layout/layout.html", 'r')
    layout = layout_file.read
    title = 'testtitle'
    content = '<pre class="brush:ruby">def TestMethod</pre>'
    date = Date.new

    html = Rack::Blogengine::DocumentParser.fill_file_contents(layout, title, content, date)
    assert(html.include?(title), 'Parsed and filled in HTML should contain Title')
    assert(html.include?('highlight'), 'Parsed and filled in HTML with pygment handling should contain .highlight class')
    assert(html.include?(date.strftime('%d.%m.%Y')), 'Parsed and filled in HTML should contain Date')
  end

  def test_get_file_contents
    Rack::Blogengine::DocumentParser.title = ''
    Rack::Blogengine::DocumentParser.content = ''
    Rack::Blogengine::DocumentParser.date = ''

    Rack::Blogengine::DocumentParser.target = "#{Rack::Blogengine.root}/assets"
    Rack::Blogengine::DocumentParser.get_file_contents('index.content')

    assert_equal('INDEX', Rack::Blogengine::DocumentParser.title, 'Parsed in Title should eql Title in test .content file')
    assert_equal('<h2>This is the Index Page</h2>', Rack::Blogengine::DocumentParser.content, 'Parsed in Content should eql Content in test .content file')
    assert_instance_of(Date, Rack::Blogengine::DocumentParser.date, 'Parsed in Date should be of Class Date')
  end

  def test_get_file_contents_invalid_date
    Rack::Blogengine::DocumentParser.target = "#{Rack::Blogengine.root}/assets"
    assert_raises(RuntimeError) { Rack::Blogengine::DocumentParser.get_file_contents('date_error.content') }
  end

  def test_get_file_contents_invalid_content
    Rack::Blogengine::DocumentParser.target = "#{Rack::Blogengine.root}/assets"
    assert_raises(RuntimeError) { Rack::Blogengine::DocumentParser.get_file_contents('content_error.content') }
  end

  def test_get_file_contents_invalid_title
    Rack::Blogengine::DocumentParser.target = "#{Rack::Blogengine.root}/assets"
    assert_raises(RuntimeError) { Rack::Blogengine::DocumentParser.get_file_contents('title_error.content') }
  end

  def test_get_content_array
    content = '[path]:[/path]
               [title]:INDEX[/title]
               [date]:2013,01,01[/date]
               [content]:
               <h2>This is the Index Page</h2>
               [/content]'
    contentarray = Rack::Blogengine::DocumentParser.get_content_array(content)

    assert_equal(4, contentarray.length, 'The content Array should contain 4 members (Path, Title, Date, Content)')
    assert(contentarray[0].include?('path'), 'First Entry should contain the path')
    assert(contentarray[1].include?('title'), 'Second Entry should contain the title')
    assert(contentarray[2].include?('date'), 'Third Entry should contain the date')
    assert(contentarray[3].include?('content'), 'Fourth Entry should contain the content')
  end

  def test_sort
    documents = []
    document1 = Rack::Blogengine::Document.new
    document1.date = Date.new(2013, 12, 12)
    document2 = Rack::Blogengine::Document.new
    document2.date = Date.new(2012, 12, 12)
    documents << document1 << document2
    documents = Rack::Blogengine::DocumentParser.sort(documents)

    assert_equal(Date.new(2012, 12, 12), documents[0].date, 'Documents should be sorted by date (earlier first)')
  end

  def test_highlight
    content = 'def TestMethod'
    highlighted = Rack::Blogengine::DocumentParser.highlight(content, 'ruby', testpath)
    assert_match(/.highlight/, highlighted, 'Highlighted html should contain a element with class highlight')
  end

  def test_highlight_fail
    content = 'def TestMethod'
    highlighted = Rack::Blogengine::DocumentParser.highlight(content, nil, testpath)
    assert_equal(content, highlighted, 'If Language is not defined Content should be returned unmodified')
  end

  def test_generate_highlight_css
    Rack::Blogengine::DocumentParser.generate_highlight_css(testpath)
    # css = Pygments.css(Rack::Blogengine.config['pygments_style'])
    highlightcss = ::File.read("#{testpath}/assets/style/highlight.css")
    # assert_equal(css, highlightcss, 'Highlight Css file should be automatically filled in')
    refute_empty(highlightcss, 'Highlight Css file should be automatically filled in')
  end

  def test_get_highlight_code
    content = '<html><head><title>Test</title></head><body><pre class="brush:ruby">def TestMethod</pre></body></html>'
    seperator = Rack::Blogengine.config['pygments_seperator']
    highlight_code = Rack::Blogengine::DocumentParser.get_highlight_code(content, seperator)

    assert_equal('def TestMethod', highlight_code[:text], "Code between #{seperator} should be returned")
    assert_equal('ruby', highlight_code[:brush], 'Brush should be recognised by the class attribute')
  end

  def teardown
    system("rm -rf #{testpath}")
  end
end
