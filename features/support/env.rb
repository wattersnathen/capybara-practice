require "capybara/cucumber"
require "selenium/webdriver"
require 'yaml'
require 'json'
require 'os'
require 'report_builder'
require 'webdrivers'
require 'pry'
require 'rspec'

ENV['run'] ||= 'local'
ENV['browser'] ||= 'chrome'
ENV['sys'] ||= 'windows'
ENV['webdrivers_dir'] ||= './webdrivers'

$filePath = Dir.pwd.gsub('/','/')+"/features/support/"

@lang = ENV['app_lang']
Webdrivers.install_dir = ENV['webdrivers_dir']

if ENV['run'] == 'local'
  capabilities = {
      commandTimeout: 600
  }
  if ENV['browser'] == 'chrome'
    Capybara.default_driver = :selenium
    browserName = :chrome
  end
  Capybara.register_driver :selenium do |app|
    Capybara::Selenium::Driver.new(app,
                                   browser: browserName,
                                   desired_capabilities: capabilities
    )
  end

  Capybara.app_host = 'https://americas.datasite.com'
  Capybara.default_max_wait_time = 10
  window = Capybara.current_session.driver.browser.manage.window
end