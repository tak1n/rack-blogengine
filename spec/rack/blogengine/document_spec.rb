require 'spec_helper'

describe Rack::Blogengine::Document do
  before do
    @document = Rack::Blogengine::Document.new

    @document.title = 'testtitle'
    @document.path = '/test'
    @document.date = '20-20-2014'
    @document.html = '<html><h1>Test</h1></html>'
  end

  describe '#new' do
    it 'should be an instance of Document' do
      @document.class.must_equal Rack::Blogengine::Document
    end

    it 'should have content when parsed in' do
      @document.title.must_equal 'testtitle'
      @document.path.must_equal '/test'
      @document.date.must_equal '20-20-2014'
      @document.html.must_equal '<html><h1>Test</h1></html>'
    end
  end

  describe '#to_hash' do
    it 'should return the right hash' do
      hashed = @document.to_hash

      hashed.key?(:path).must_equal true
      hashed.key?(:html).must_equal true
    end
  end
end
