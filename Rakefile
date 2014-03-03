# require "bundler/gem_tasks"
require 'rake/testtask'
# require 'cucumber/rake/task'

require "sinatra/activerecord/rake"
require "./autoloader"

namespace :db do
  task :custom_create do
    ActiveRecord::Tasks::DatabaseTasks.create(Database.config[ENV['RACK_ENV']])
  end
end

namespace :test do
  Rake::TestTask.new(:unit) do |t|
    t.libs << "test" << "bin" << "ext" << "controllers" << "helpers" << "models"
    t.test_files = FileList['test/**/*_test.rb']
    t.verbose = true
  end

  Rake::TestTask.new(:spec) do |t|
    t.libs << "spec" << "bin" << "ext" << "controllers" << "helpers" << "models"
    t.test_files = FileList['spec/**/*_spec.rb']
    t.verbose = true
  end

 # Cucumber::Rake::Task.new(:feature) do |t|
 #  t.cucumber_opts = "features --format pretty"
 # end
end

test_runs = if ENV['TESTS']
              Interger(ENV['TESTS'])
            else
              30
            end

namespace :floodtest do
  task :unit do
    1.upto(test_runs) do |i|
      puts "Running test #{i} of #{test_runs}"
      exit(-1) if !system('bundle exec rake test:unit')
    end
  end

  task :spec do
    1.upto(test_runs) do |i|
      puts "Running test #{i} of #{test_runs}"
      exit(-1) if !system('bundle exec rake test:spec ')
    end
  end

  # task :feature do
   # 1.upto(test_runs) do |i|
   #   puts "Running test #{i} of #{test_runs}"
   #   exit(-1) if !system('bundle exec rake test:feature')
   #  end
  # end
end

task :default do
  Rake::Task['test:unit'].invoke
  # Rake::Task['test:spec'].invoke
  # Rake::Task['test:feature'].invoke
end
