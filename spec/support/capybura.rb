# frozen_string_literal: true

Capybara.register_driver :remote_chrome do |app|
  url = ENV['SELENIUM_DRIVER_URL']
  caps = ::Selenium::WebDriver::Remote::Capabilities.chrome(
    'goog:chromeOptions' => {
      'args' => [
        'no-sandbox',
        'headless',
        'disable-gpu',
        'window-size=1440,900'
      ]
    }
  )
  Capybara::Selenium::Driver.new(app, browser: :remote, url: url, desired_capabilities: caps, timeout: 300)
end

RSpec.configure do |config|
  config.before(:each, type: :system) do
    driven_by :rack_test
  end

  config.before(:each, type: :system, js: true) do
    if ENV['SELENIUM_DRIVER_URL'].present?
      Capybara.server_host = IPSocket.getaddress(Socket.gethostname)
      Capybara.app_host = "http://#{Capybara.server_host}"
      driven_by :remote_chrome
    else
      driven_by :selenium_chrome_headless
    end
  end
end
