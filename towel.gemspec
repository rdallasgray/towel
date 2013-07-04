# encoding: utf-8

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'towel/version'

Gem::Specification.new do |spec|
  spec.name          = 'towel'
  spec.version       = Towel::VERSION
  spec.authors       = ['Robert Dallas Gray']
  spec.email         = ['mail@robertdallasgray.com']
  spec.description   = %q{A RESTful starting point for Rails controllers}
  spec.summary       = %q{Dry up Rails controllers}
  spec.homepage      = 'https://github.com/rdallasgray/towel.git'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.test_files    = spec.files.grep(/spec\//)
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'activesupport', '~> 3'
  spec.add_development_dependency 'guard', '>= 1.8'
  spec.add_development_dependency 'guard-minitest'
  spec.add_development_dependency 'mocha'
end
