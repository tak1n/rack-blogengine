require "bundler/gem_tasks"
require 'rake/testtask'
require 'cucumber/rake/task'


namespace :test do
  Rake::TestTask.new(:unit) do |t|
    t.libs << "test"
    t.test_files = FileList['test/**/*_test.rb']
    t.verbose = true
  end

  Rake::TestTask.new(:spec) do |t|
    t.libs << "spec"
    t.test_files = FileList['spec/**/*_spec.rb']
    t.verbose = true
  end

  Cucumber::Rake::Task.new(:feature) do |t|
    t.cucumber_opts = "features --format pretty"
  end
end

task :default do
  Rake::Task['test:unit'].invoke
  # Rake::Task['test:spec'].invoke
  Rake::Task['test:feature'].invoke
end