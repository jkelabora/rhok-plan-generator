require 'capybara'
require 'capybara/dsl'
require 'capybara/poltergeist'
require 'capybara/rspec'
require 'phantomjs'

ENV['RACK_ENV'] ||= 'test'

Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(app, :phantomjs => Phantomjs.path)
end

Capybara.default_driver = :poltergeist
Capybara.run_server = false
Capybara.app_host = "http://localhost:3000"    
