# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rack/blogengine/version'

Gem::Specification.new do |spec|
  spec.name          = "rack-blogengine"
  spec.version       = Rack::Blogengine::VERSION
  spec.authors       = ["Benny Klotz"]
  spec.email         = ["benny.klotz92@gmail.com"]
  spec.description   = %q{Blogengine based on rack applications}
  spec.summary       = "#{spec.description}"
  spec.homepage      = "https://github.com/tak1n/rack-blogengine"
  spec.license       = "MIT"

  spec.post_install_message = 'Please report any issues at: ' \
      'https://github.com/tak1n/rack-blogengine/issues/new'

  # spec.cert_chain  = ['certs/benny1992.pem']
  # spec.signing_key = File.expand_path("~/.ssh/gem-private_key.pem") if $0 =~ /gem\z/

  spec.files         = File.read(File.expand_path('../MANIFEST', __FILE__)).split("\n")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.required_ruby_version = '>= 2.5.7'
  spec.add_runtime_dependency 'rack', '~> 2.2'
  spec.add_runtime_dependency 'pygments.rb', '~> 1.2'
  spec.add_runtime_dependency 'nokogiri', '~> 1.10'

  spec.add_development_dependency 'bundler', '~> 2.1'
  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'coveralls', '~> 0.8'
  spec.add_development_dependency 'rack-test', '~> 1.1'
  spec.add_development_dependency 'minitest', '~> 5.14'
  spec.add_development_dependency 'minitest-reporters', '~> 1.4'
  spec.add_development_dependency 'pry', '~> 0.12'
  spec.add_development_dependency 'rubocop', '~> 0.80'
  spec.add_development_dependency 'codeclimate-test-reporter', '~> 1.0'
end
