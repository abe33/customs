# -*- encoding: utf-8 -*-
require File.expand_path('../lib/cancan-traffic/version', __FILE__)

Gem::Specification.new do |s|
  s.name          = 'cancan-traffic'
  s.version       = "0.0.1"

  s.authors       = 'Savater Sebastien'
  s.email         = 'savater.sebastien@gmail.com'

  s.summary       = 'Extend cancan and add some magic in your rails controllers.'
  s.homepage      = 'http://github.com/blakink/cancan-traffic'

  s.files         = %w(README.md MIT-LICENSE) + Dir["lib/**/*"]
  s.require_paths = ["lib"]

  s.required_ruby_version = '>= 1.9.2'

  s.add_dependency 'rails', '>= 3.2.0'
  s.add_dependency 'cancan', '>= 1.6.7'
end
