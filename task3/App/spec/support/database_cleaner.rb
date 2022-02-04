RSpec.configure do |config|
  config.before(:suite) do
    DatabaseCleaner[:active_record].strategy = DatabaseCleaner::ActiveRecord::Truncation.new(only: ["orders"])
    DatabaseCleaner[:redis].strategy = :deletion
  end

  config.before(:each) do
    DatabaseCleaner[:active_record].strategy = DatabaseCleaner::ActiveRecord::Truncation.new(only: ["orders"])
    DatabaseCleaner[:redis].strategy = :deletion
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end