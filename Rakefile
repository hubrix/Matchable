require 'rubygems'
Gem::manage_gems
require 'rake/gempackagetask'
begin
  require 'jeweler'
  Jeweler::Tasks.new do |s|
    s.name = 'Matchable'
    s.author = 'Mark Friedgan'
    s.email = 'mark@cashnetusa.com'
    s.homepage = 'http://hubrix.github.com/matchable/'
    s.summary = 'ML style type/value matching system for methods and case statements'
    s.authors = ["Mark Friedgan"]
  end
rescue LoadError
  puts "Jeweler not available. Install it with: sudo gem install technicalpickles-jeweler -s http://gems.github.com"
end

task :default => :test

task :rdoc do
  sh "rm -rf #{File.dirname(__FILE__)}/doc"
  sh "cd lib && rdoc -o ../doc " 
end
task :test do
  sh "ruby -I lib test/matchable_test.rb"
  puts "\n\n"
end


