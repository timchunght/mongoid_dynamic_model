require "bundler/gem_tasks"
require 'rake'
require 'rspec/core'
require "rspec/core/rake_task"

# $LOAD_PATH.unshift File.expand_path("../lib", __FILE__)
RSpec::Core::RakeTask.new("spec") do |spec|
  spec.pattern = "spec/**/*_spec.rb"
end

task :default => :spec