# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "ducksboard_reporter/version"

Gem::Specification.new do |spec|
  spec.name          = "ducksboard_reporter"
  spec.version       = DucksboardReporter::VERSION
  spec.authors       = ["unnu"]
  spec.email         = ["norman.timmler@gmail.com"]
  spec.summary       = %q{Report values to ducksboard}
  spec.description   = %q{Report values to ducksboard}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "fuubar"
  spec.add_development_dependency "byebug"
  spec.add_development_dependency "parallel_tests"

  spec.add_runtime_dependency "ducksboard", "~> 0.1.6"
  spec.add_runtime_dependency "hashie", ">= 3.3.1"
  spec.add_runtime_dependency "celluloid", "~> 0.16"
  spec.add_runtime_dependency "timers", ">= 1.1.0"
  spec.add_runtime_dependency "trollop", ">= 1.16.2"
  spec.add_runtime_dependency "faraday", ">= 0.9.0"
end
