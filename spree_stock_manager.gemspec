# encoding: UTF-8
Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'spree_stock_manager'
  s.version     = '2.3.1'
  s.summary     = 'Spree Stock Manager Extension'
  s.description = 'The stock manager extension, add a tab to manage stocks in the admin products part of your spree website'
  s.required_ruby_version = '>= 1.8.7'

  s.author    = 'Renuo GmbH, Olivier Buffon'
  s.email     = 'info@renuo.ch'
  s.homepage  = 'http://www.renuo.ch'

  #s.files       = `git ls-files`.split("\n")
  #s.test_files  = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_path = 'lib'
  s.requirements << 'none'

  s.add_dependency 'spree_core'

  s.add_development_dependency 'capybara'
  s.add_development_dependency 'factory_girl'
  s.add_development_dependency 'ffaker'
  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'sqlite3'
end
