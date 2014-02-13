require "bundler/gem_tasks"
require 'rake/testtask'



namespace :test do
  Rake::TestTask.new(:unit) do |t|
    t.libs << "test"
    t.test_files = FileList['test/*_test.rb']
    t.verbose = true
  end

  Rake::TestTask.new(:spec) do |t|
    t.libs << "spec"
    t.test_files = FileList['spec/spec_*.rb']
    t.verbose = true
  end
end

task :default => 'test:unit'