require 'capybara'
require 'capybara/dsl'
require 'rspec'

include RSpec::Matchers

RSpec.configure do |config|
  config.include Capybara::DSL, type: :feature
end


$browser = 'chrome'

Capybara.configure do |config|
  config.run_server = false
  config.default_driver = :selenium
  config.javascript_driver = :selenium
  config.default_selector = :css
  config.app_host = $URL
  config.default_max_wait_time = 120
  config.ignore_hidden_elements = false
end

if $REMOTE_URL.to_s != ''
  Capybara.register_driver :selenium do |app|
    # Capybara::Selenium::Driver.new(app, browser: :remote, url: $REMOTE_URL, desired_capabilities: :"#{$browser}")

    prefs = {'profile.managed_default_content_settings.notifications' => 2,
             'useAutomationExtension' => false,
             'args' => %w(--disable-web-security --start-maximized --disable-infobars)}

    profile = Selenium::WebDriver::Chrome::Profile.new
    client = Selenium::WebDriver::Remote::Http::Default.new
    client.timeout = 180 # instead of the default 60
    caps = Selenium::WebDriver::Remote::Capabilities.chrome(chrome_options: {prefs: prefs})

    Capybara::Selenium::Driver.new(app, browser: :remote,
                                   desired_capabilities: caps,
                                   profile: profile,
                                   http_client: client)
  end
  # Required for remote file uploads
  Capybara.current_session.driver.browser.file_detector = lambda do |args|
    str = args.first.to_s
    str if File.exist?(str)
  end
else
  Capybara.register_driver :selenium do |app|
    prefs = {'profile.managed_default_content_settings.notifications' => 2}

    caps = Selenium::WebDriver::Remote::Capabilities.chrome(chrome_options: {prefs: prefs})

    profile = Selenium::WebDriver::Chrome::Profile.new
    profile['profile.default_content_settings'] = {images: '2'}

    Capybara::Selenium::Driver.new(app,
                                   browser: :"#{$browser}",
                                   desired_capabilities: caps,
                                   profile: profile)
  end
end
