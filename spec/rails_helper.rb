require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../config/environment', __dir__)
abort('The Rails environment is running in production mode!') if Rails.env.production?
require 'rspec/rails'
require 'capybara/rspec'
require 'webdrivers/chromedriver'
# include Capybara::DSL

# Capybara.register_driver :selenium_chrome do |app|
Capybara.register_driver :chrome do |app|
  Capybara::Selenium::Driver.new(app, browser: :chrome)
end

Capybara.default_driver = :selenium_chrome
# Capybara.javascript_driver = :selenium_chrome

# Capybara.register_driver :headless_chrome do |app|
#   capabilities = Selenium::WebDriver::Remote::Capabilities.chrome(
#     chromeOptions: {
#       args: %w[headless enable-features=NetworkService,NetworkServiceInProcess]
#     }
#   )

#   Capybara::Selenium::Driver.new app,
#     browser: :chrome,
#     desired_capabilities: capabilities
# end

# Capybara.default_driver = :headless_chrome
# Capybara.javascript_driver = :headless_chrome

# If not using ActiveRecord, can remove these lines.
begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end

RSpec.configure do |config|
  # Remove if not using ActiveRecord or fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # clean setup after transaction
  config.use_transactional_fixtures = true

  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!

  # re-build db when start test suit
  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each, js: true) do
    DatabaseCleaner.strategy = :truncation
  end

  # capybara setup
  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end

  config.include Capybara::DSL
end
