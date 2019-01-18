# coding: utf-8
$LOAD_PATH.push File.expand_path('../lib', __FILE__)
require 'ndr_ui/version'

Gem::Specification.new do |spec|
  spec.name          = 'ndr_ui'
  spec.version       = NdrUi::VERSION
  spec.authors       = ['NDR Development Team']
  spec.email         = []
  spec.summary       = 'NDR UI Rails Engine'
  spec.description   = 'Provides Rails applications with additional support for the ' \
                       'Twitter Bootstrap UI framework'
  spec.homepage      = 'https://github.com/PublicHealthEngland/ndr_ui'
  spec.license       = 'MIT'

  spec.files = Dir['{app,config,lib,vendor}/**/*', 'LICENSE.txt', 'Rakefile', 'README.md'] - ['.travis.yml']

  spec.required_ruby_version = '>= 2.4.0'

  spec.add_dependency 'rails', '>= 5.1', '< 6.0'
  spec.add_dependency 'bootstrap-sass', '~> 3.3.6'
  spec.add_dependency 'sass-rails', '>= 3.2'
  spec.add_dependency 'jquery-rails', '>= 4.1.0'

  spec.add_development_dependency 'sqlite3'

  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'ndr_dev_support', '~> 3.1', '>= 3.1.3'
  spec.add_development_dependency 'simplecov'
  spec.add_development_dependency 'mocha', '~> 1.1.0'
end
