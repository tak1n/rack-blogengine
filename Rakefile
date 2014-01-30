require "bundler/gem_tasks"
require 'rake/testtask'

Rake::TestTask.new do |t|
  t.libs << "test"
  t.test_files = FileList['test/*_test.rb']
  t.verbose = true
end

task :testall do 
  Dir.foreach("test") do |item|
    if item.include? "_test"
      puts "\nTesting #{item} \n\n"
      system("ruby test/#{item}")
      sleep(18)
  	end
  end
end