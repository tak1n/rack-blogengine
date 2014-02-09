require "bundler/gem_tasks"
require 'rake/testtask'
require 'rspec/core/rake_task'



namespace :test do
  Rake::TestTask.new(:unit) do |t|
    t.libs << "test"
    t.test_files = FileList['test/*_test.rb']
    t.verbose = true
  end

  RSpec::Core::RakeTask.new(:spec)
end

task :default => 'test:unit'