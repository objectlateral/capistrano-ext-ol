# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "capistrano/ext/ol/version"

Gem::Specification.new do |spec|
  spec.name          = "capistrano-ext-ol"
  spec.version       = Capistrano::Ext::Ol::VERSION
  spec.authors       = ["Jerod Santo"]
  spec.email         = ["jerod@objectlateral.com"]
  spec.description   = %q{Custom capistrano extensions used at OL}
  spec.summary       = %q{Custom capistrano extensions used at OL}
  spec.homepage      = "https://github.com/objectlateral/capistrano-ext-ol"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "capistrano", "~>2.15"
  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
