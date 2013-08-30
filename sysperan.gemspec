# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sysperan/version'

Gem::Specification.new do |spec|
  spec.name          = "sysperan"
  spec.version       = Sysperan::VERSION
  spec.authors       = ["Mark Lanett"]
  spec.email         = ["mark.lanett@gmail.com"]
  spec.description   = %q{System Performance Analysis}
  spec.summary       = %q{System Performance Analysis}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'algorithms'
  spec.add_dependency 'json'
  spec.add_dependency 'redis',                '~> 3.0.4'

  spec.add_development_dependency 'bundler',  '~> 1.3'
  spec.add_development_dependency 'rake'
end
