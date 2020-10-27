# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'security_roles_client/version'

Gem::Specification.new do |spec|
  spec.name          = 'security_roles_client'
  spec.version       = SecurityRolesClient::VERSION
  spec.authors       = ['Danilo Barion Nogueira']
  spec.email         = ['danilo.barion1986@live.com']

  spec.summary       = 'Generic client for Security Roles Service'
  spec.description   = 'This is a generic client for use in conjunction with a security roles service/API.'

  spec.files         = Dir.glob(File.join(__FILE__, '**', '*_spec.rb'))
  spec.require_paths = ['lib']

  spec.required_ruby_version = '~> 2.6.0'

  spec.add_dependency 'dry-configurable', '~> 0.11.0'
  spec.add_dependency 'dry-schema', '~> 1.5.6'
  spec.add_dependency 'json', '~> 2.3.0'

  spec.add_development_dependency 'bundler', '~> 2.1.0'
  spec.add_development_dependency 'pry-byebug', '~> 3.9.0'
  spec.add_development_dependency 'rake', '~> 13.0.0'
  spec.add_development_dependency 'rspec', '~> 3.9.0'
  spec.add_development_dependency 'rubocop', '~> 1.0.0'
  spec.add_development_dependency 'rubocop-performance', '~> 1.8.1'
  spec.add_development_dependency 'rubycritic', '~> 4.5.2'
  spec.add_development_dependency 'simplecov', '~> 0.19.0'
  spec.add_development_dependency 'yard', '~> 0.9.25'
end
