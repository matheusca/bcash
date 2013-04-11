# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'bcash/version'

Gem::Specification.new do |spec|
  spec.name          = "bcash"
  spec.version       = Bcash::VERSION
  spec.authors       = ["Matheus Caceres"]
  spec.email         = ["matheuscaceres@gmail.com"]
  spec.description   = %q{Integration with BCash}
  spec.summary		 = %q{Integration with BCash}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "activemodel"
  spec.add_dependency "rest-client"
  spec.add_dependency "haml"
  spec.add_dependency "nokogiri"
  spec.add_dependency "actionpack"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "rake"
end
