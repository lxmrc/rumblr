RSpec.configure do |config|
  Capybara.register_driver :firefox do |app|
    Capybara::Selenium::Driver.new(app, browser: :firefox)
  end

  Capybara.register_driver :headless_firefox do |app|
    options = Selenium::WebDriver::Firefox::Options.new
    options.headless!

    Capybara::Selenium::Driver.new app,
      browser: :firefox,
      options: options
  end

  Capybara.javascript_driver = ENV['GUI'] ? :firefox : :headless_firefox
end
