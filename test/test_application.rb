require 'test_helper'
 
describe Rack::Blogengine::Application do
  it "must be defined" do
    Rack::Blogengine::VERSION.wont_be_nil
  end 
end