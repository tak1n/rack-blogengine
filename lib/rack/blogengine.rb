require_relative "blogengine/version"
require_relative 'blogengine/application_response'

require 'rack'


run Rack::Blogengine::ApplicationResponse