# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mongoid_dynamic_model/version'
require 'mongoid_dynamic_model/mongoid_dynamic_model'

Gem::Specification.new do |spec|
  spec.name          = "mongoid_dynamic_model"
  spec.version       = Mongoid::DynamicModel::VERSION
  spec.authors       = ["Timothy Chung"]
  spec.email         = ["timchunght@gmail.com"]
  spec.summary       = %q{Dynamically Generate Mongoid model in Rails or other Ruby frameworks}
  spec.description   = %q{Dynamically Generate Mongoid model in Rails or other Ruby frameworks}
  spec.homepage      = ""
  spec.license       = ""

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]
  spec.add_runtime_dependency 'mongoid'
  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end
