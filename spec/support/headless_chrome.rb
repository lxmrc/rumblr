RSpec.configure do |config|
  options = Selenium::WebDriver::Chrome::Options.new
  options.add_preference(:download, prompt_for_download: false,
                                    default_directory: '/tmp/downloads')

  options.add_preference(:browser, set_download_behavior: { behavior: 'allow' })

  Capybara.register_driver :chrome do |app|
    Capybara::Selenium::Driver.new(app, browser: :chrome, options: options)
  end

  Capybara.register_driver :headless_chrome do |app|
    options.add_argument('--headless')
    options.add_argument('--disable-gpu')
    options.add_argument('--window-size=1280,800')

    Capybara::Selenium::Driver.new app, 
      browser: :chrome, 
      options: options
  end

  Capybara.javascript_driver = ENV['GUI'] ? :chrome : :headless_chrome
end
