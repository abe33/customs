# encoding: UTF-8
require File.expand_path('../lib/traffic/version', __FILE__)

Gem::Specification.new do |s|
  s.name        = 'traffic'
  s.platform    = Gem::Platform::RUBY
  s.version     = Traffic::VERSION

  s.required_ruby_version = '>= 1.9.2'
  s.author      = 'Sebastien Savater'
  s.email       = 'savater.sebastien@gmail.com'
  s.homepage    = 'http://github.com/blakink/traffic'

  s.summary     = 'Add some magic in your rails controllers.'

  s.files         = %w(README.md MIT-LICENSE) + Dir["lib/**/*"]
  s.require_paths = %w(lib)

  s.add_dependency 'rails', '>= 3.2.0'
  s.add_dependency 'cancan', '>= 1.6.7'
end
