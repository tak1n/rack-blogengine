require 'simplecov'
require 'coveralls'

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[
  SimpleCov::Formatter::HTMLFormatter,
  Coveralls::SimpleCov::Formatter
]

SimpleCov.start do
  project_name 'rack-blogengine'
  add_filter '/test/'
  add_filter '/pkg/'
  add_filter '/spec/'
  add_filter '/features/'
  add_filter '/doc/'
  add_filter '/assets/'
end if ENV["COVERAGE"]

require 'capybara/cucumber'
require 'rack/blogengine'

Rack::Blogengine.documents = [{ html: '<!DOCTYPE html><body><h2>index</h2></body></html>',
                                path: '/' }]

Capybara.app = Rack::Blogengine::Application
