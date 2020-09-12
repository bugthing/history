require 'pry'
RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
end

require_relative '../system/container'

RSpec.configure do |config|
  config.around(db: :test) do |example|
    orginal_url = ENV['DATABASE_URL']
    ENV['DATABASE_URL'] = 'sqlite://./tmp/test_db.sqlite'
    rom = ROM.container(:sql, ['sqlite://./tmp/test_db.sqlite'])
    rom.gateways[:default].run_migrations
    example.run
    #ENV['DATABASE_URL'] = orginal_url
  end
end
