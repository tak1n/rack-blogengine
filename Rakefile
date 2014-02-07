require "bundler/gem_tasks"
require 'rake/testtask'
require 'rubocop/rake_task'

namespace :test do
  Rake::TestTask.new(:unit) do |t|
    t.libs << "test"
    t.test_files = FileList['test/*_test.rb']
    t.verbose = true
  end
end

task :default => 'test:unit'