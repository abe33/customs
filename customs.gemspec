# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name          = 'customs'
  s.version       = '1.0.0'

  s.authors       = 'Savater Sebastien'
  s.email         = 'savater.sebastien@gmail.com'

  s.description   = 'Control the traffic of your rails controllers.'
  s.summary       = 'Control the traffic of your rails controllers.'
  s.homepage      = 'http://github.com/blakink/customs'

  s.files         = Dir.glob('{app,config,lib}/**/*') + %w(Gemfile LICENSE README.md Rakefile)
  s.require_paths = %w(lib)

  s.required_ruby_version = '>= 1.8.7'

  s.add_dependency 'rails',  '>= 3.2.0'
  s.add_dependency 'cancan', '>= 1.6.7'
end
