# -*- encoding: utf-8 -*-

Gem::Specification.new do |gem|
  gem.name    = 'blindfold'
  gem.version = '0.0.2'
  gem.date    = %{2010-06-24}

  gem.authors  = ["James Bunch (fallwith)"]
  gem.email    = nil
  gem.homepage = 'http://github.com/fallwith/blindfold'

  gem.summary     = "API/XML focused integration testing for Rack apps"
  gem.description = "Blindfold brings together RSpec, Rack::Test, and Machinist for the
                     express purpose of providing integration test coverage for web based
                     API services (especially those with an XML response)."

  gem.files = [
    '.gitignore',
    'bin/blindfold',
    'blindfold.gemspec',
    'config/spec.opts',
    'init.rb',
    'lib/blindfold/connection.rb',
    'lib/blindfold/helpers/date.rb',
    'lib/blindfold/helpers/db.rb',
    'lib/blindfold/helpers.rb',
    'lib/blindfold/launcher.rb',
    'lib/blindfold/spec/matchers/be_an_ip_address.rb',
    'lib/blindfold/spec/matchers/be_an_iso_date.rb',
    'lib/blindfold/spec/matchers/be_ok.rb',
    'lib/blindfold/spec/monkey.rb',
    'lib/blindfold/spec.rb',
    'lib/blindfold/xml/monkey.rb',
    'lib/blindfold/xml.rb',
    'lib/blindfold.rb',
    'MIT-LICENSE',
    'Rakefile',
    'README.rdoc',
    'VERSION'
  ]

  gem.add_dependency('rspec', '>= 1.3.0')
  gem.add_dependency('rack-test', '>= 0.5.4')
  gem.add_dependency('machinist', '>= 1.0.6')
  gem.add_dependency('forgery', '>= 0.3.4')
end
