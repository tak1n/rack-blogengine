require 'spec_helper'

describe Rack::Blogengine::Document do
  before :all do
    @document = Rack::Blogengine::Document.new

    @document.title = 'testtitle'
    @document.path = '/test'
    @document.date = '20-20-2014'
    @document.html = '<html><h1>Test</h1></html>'
  end

  describe '#new' do
    it 'should be an instance of Document' do
      @document.class.should eql Rack::Blogengine::Document
    end

    it 'should have content when parsed in' do
      @document.title.should eql 'testtitle'
      @document.path.should eql '/test'
      @document.date.should eql '20-20-2014'
      @document.html.should eql '<html><h1>Test</h1></html>'
    end
  end

  describe '#to_hash' do
    it 'should return the right hash' do
      hashed = @document.to_hash

      hashed.key?(:path).should be_true
      hashed.key?(:html).should be_true
    end
  end
end
