require 'capybara/cucumber'
require 'rack/blogengine'

Rack::Blogengine::documents = [{ html: '<!DOCTYPE html><body><h2>index</h2></body></html>',
                   path: '/' }]
Capybara.app = Rack::Blogengine::Application
