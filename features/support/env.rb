require 'rubygems'
require 'bundler/setup'
require 'capybara/cucumber'
require 'selenium-webdriver'
require 'pry'

SERVER_URL  = 'http://www.myrapname.com/'
WEB_BROWSER ||= :chrome

# Local development
Capybara.register_driver WEB_BROWSER do |app|
  prefs = {
      prompt_for_download: false,
      credentials_enable_service: false
  }

  options = Selenium::WebDriver::Chrome::Options.new
  options.add_preference(:download, prefs)
  options.add_argument("disable-infobars")

  Capybara::Selenium::Driver.new(app, browser: WEB_BROWSER, options: options)
end

Capybara.configure do |config|
  config.default_driver = WEB_BROWSER
  config.app_host = SERVER_URL
end

# HOOKS
Before do |scenario|
  visit SERVER_URL
end

After do |scenario|
end
