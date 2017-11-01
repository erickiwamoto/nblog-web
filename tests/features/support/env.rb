require 'capybara'
require 'capybara/cucumber'
require 'capybara/poltergeist'
require 'selenium-webdriver'
require 'rspec'
require 'faker'
require 'site_prism'

$env = ENV['ENVIRONMENT']

$data = YAML.load_file(File.dirname(__FILE__) + '/env.yaml')

Capybara.register_driver :selenium do |app|
  Capybara::Poltergeist::Driver.new(
    app,
    options = {
      js_errors: false
    }
  )
end

Capybara.configure do |config|
  config.default_driver = :selenium
  config.app_host = $data['url'][$env]
end

Capybara.default_max_wait_time = 5