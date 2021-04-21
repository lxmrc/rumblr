source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.0.0"

gem "rails", "~> 6.1.3"
gem "pg", "~> 1.1"
gem "puma", "~> 5.0"
gem "sass-rails", ">= 6"
gem "webpacker", "~> 5.0"
gem "turbolinks", "~> 5"
gem "bootsnap", ">= 1.4.4", require: false
gem "devise", "~> 4.7", ">= 4.7.3"
gem "simple_form", "~> 5.1"
gem "friendly_id", "~> 5.4", ">= 5.4.2"
gem "image_processing", "~> 1.2"
gem "aws-sdk-s3", "~> 1.93", require: false
gem "ancestry", "~> 3.2", ">= 3.2.1"

group :development, :test do
  gem "pry-rails"
  gem "pry-byebug"
  gem "rspec-rails"
  gem "factory_bot_rails"
  gem "capybara"
  gem "selenium-webdriver"
  gem "rexml"
  gem "simplecov", require: false
  gem "standard"
  gem "guard-rspec"
end

group :development do
  gem "web-console"
  gem "listen"
  gem "spring"
end
