# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rack/blogengine/version'

Gem::Specification.new do |spec|
  spec.name          = "rack-blogengine"
  spec.version       = Rack::Blogengine::VERSION
  spec.authors       = ["Benny1992"]
  spec.email         = ["klotz.benjamin@yahoo.de"]
  spec.description   = %q{Blogengine based on rack applications}
  spec.summary       = "#{spec.description}"
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib", "spec"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  #spec.add_development_dependency "rspec", ">= 2.0.0"

  spec.add_runtime_dependency "rack"
end