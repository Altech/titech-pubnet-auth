# -*- encoding: utf-8 -*-

require 'rake'
require File.expand_path('../lib/titech_pubnet_auth/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Sohei Takeno"]
  gem.email         = ["takeno.sh@gmail.com"]
  gem.description   = 'This gem provides automatic authentication for titech-pubnet.'
  gem.summary       = 'This gem provides automatic authentication for titech-pubnet.'
  gem.homepage      = 'http://for-titech.herokuapp.com'
  
  gem.files = FileList['lib/**/*', 'bin/*', 'config/private.yml.example', 'Rakefile', 'Gemfile', 'README.md', 'titech_pubnet_auth.gemspec'].to_a
  
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.name          = "titech-pubnet-auth"
  gem.require_paths = ["lib"]
  gem.version       = TitechPubnetAuth::VERSION

  gem.add_dependency 'colorize'
  gem.add_dependency 'mechanize', '~> 2.7'
  gem.add_dependency 'terminal-notifier', '~> 1.4'
  gem.add_dependency 'ruby-keychain'
  gem.add_dependency 'virtus', '~> 1.0'

  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'rspec'
  gem.add_development_dependency 'yard'
  gem.add_development_dependency 'webmock'
end
