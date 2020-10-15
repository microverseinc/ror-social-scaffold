require 'database_cleaner'

RSpec.configure do |config|
  # config.before(:suite) do
  #   DatabaseCleaner.strategy = :deletion
  #   DatabaseCleaner.clean_with(:deletion)
  # end

  # config.around(:each) do |example|
  #   DatabaseCleaner.cleaning do
  #     example.run
  #   end
  # end

  config.before(:suite) do
    DatabaseCleaner.clean_with :truncation, except: %w(ar_internal_metadata)
  end

  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end