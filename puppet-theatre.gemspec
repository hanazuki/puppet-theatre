# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'puppet_theatre/version'

Gem::Specification.new do |spec|
  spec.name          = 'puppet-theatre'
  spec.version       = PuppetTheatre::VERSION
  spec.authors       = ['Kasumi Hanazuki']
  spec.email         = ['kasumi@rollingapple.net']

  spec.summary       = %q{Automation framework for continuous infra testing}
  spec.description   = %q{Automation framework for continuous infra testing}
  spec.homepage      = 'https://github.com/hanazuki/puppet-theatre'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split(?\0).reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'sshkit', '1.9.0'
  spec.add_dependency 'parallel', '1.10.0'

  spec.add_development_dependency 'bundler', '~> 1.11'
  spec.add_development_dependency 'rake', '~> 11.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'timecop', '~> 0.8'
end
