# encoding: UTF-8
require File.expand_path('../lib/skin-resources/version', __FILE__)

Gem::Specification.new do |s|
  s.name        = 'skin-resources'
  s.platform    = Gem::Platform::RUBY
  s.version     = SkinResources::VERSION

  s.required_ruby_version = '>= 1.9.2'
  s.author      = 'Sebastien Savater'
  s.email       = 'savater.sebastien@gmail.com'
  s.homepage    = 'http://github.com/blakink/skin-resources'

  s.summary     = 'Common methods to make that controllers manage resources.
    Built to work well with the Skin gem, but not only...'

  s.files         = %w(README.md MIT-LICENSE) + Dir["lib/**/*"]
  s.require_paths = %w(lib)

  s.add_dependency 'rails', '~> 3.2.0'
  s.add_dependency 'coffee-rails','>= 3.2.1'
end
