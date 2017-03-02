# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'webmoney_files/version'

Gem::Specification.new do |spec|
  spec.name          = 'webmoney-files'
  spec.version       = WebmoneyFiles::VERSION
  spec.authors       = ['Denis Sobolev']
  spec.email         = ['dns.sobol@gmail.com']

  spec.summary       = 'WebMoney Files Ruby SDK'
  spec.description   = 'Wrapper for WebMoney Filese API'
  spec.homepage      = 'https://github.com/umount/webmoney-files'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'rest-client', '~> 0'
  spec.add_dependency 'webmoney', '~> 0'

  spec.add_development_dependency 'bundler', '~> 1.11'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
end
