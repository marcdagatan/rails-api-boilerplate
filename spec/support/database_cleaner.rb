RSpec.configure do |config|
  # Set the default cleaning strategy to :transaction
  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
  end

  # Start the Database Cleaner before each test
  config.before do
    DatabaseCleaner.start
  end

  # Clean up the database after each test runs
  config.after do
    DatabaseCleaner.clean
  end

  # Use truncation strategy for tests that require it (e.g., Capybara tests)
  config.before(:each, type: :feature) do
    DatabaseCleaner.strategy = :truncation
  end

  # Reset the strategy back to :transaction after each test
  config.after(:each, type: :feature) do
    DatabaseCleaner.strategy = :transaction
  end
end
