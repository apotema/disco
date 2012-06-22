require File.expand_path('../config/application', __FILE__)
require 'ci/reporter/rake/rspec'
Disco::Application.load_tasks

task :test => :spec
task :default => :spec
task :spec => [:'db:test:prepare', :'ci:setup:rspec']

begin
  require 'bundler/setup'
rescue LoadError
  puts 'You must `gem install bundler` and `bundle install` to run rake tasks'
end