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

  case ENV['GUI']
  when 'true', '1'
    Capybara.javascript_driver = :firefox
  else
    Capybara.javascript_driver = :headless_firefox
  end
end
