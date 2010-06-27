# -*- encoding: utf-8 -*-

Gem::Specification.new do |gem|
  gem.name    = 'blindfold'
  gem.version = '0.0.4'
  gem.date    = %{2010-06-26}

  gem.authors  = ["James Bunch (fallwith)"]
  gem.email    = nil
  gem.homepage = 'http://github.com/fallwith/blindfold'

  gem.summary     = "API/XML focused integration testing for Rack apps"
  gem.description = "Blindfold brings together RSpec, Rack::Test, and Machinist for the
                     express purpose of providing integration test coverage for web based
                     API services (especially those with an XML response)."

  gem.files = `git ls-files -z`.split("\0").reject{|f|f =~ /^\./}

  gem.add_dependency('rspec', '>= 1.3.0')
  gem.add_dependency('rack-test', '>= 0.5.4')
  gem.add_dependency('machinist', '>= 1.0.6')
  gem.add_dependency('forgery', '>= 0.3.4')
  gem.add_dependency('nokogiri', '>= 1.3.2')
end
