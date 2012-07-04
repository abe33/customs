# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name          = 'cancan-traffic'
  s.version       = "0.0.3"

  s.authors       = 'Savater Sebastien'
  s.email         = 'savater.sebastien@gmail.com'

  s.description   = 'Extend cancan and add some magic in your rails controllers.'
  s.summary       = 'Extend cancan and add some magic in your rails controllers.'
  s.homepage      = 'http://github.com/blakink/cancan-traffic'

  s.files         = Dir.glob('{app,config,lib}/**/*') + %w(Gemfile LICENSE README.md Rakefile)
  s.require_paths = ["lib"]

  s.required_ruby_version = '>= 1.9.2'

  s.add_dependency 'rails', '>= 3.2.0'
  s.add_dependency 'cancan', '>= 1.6.7'
end
