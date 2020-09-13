require 'pry'

require_relative '../system/boot'

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups

  # # TODO: figure how to use :memory: sqlite
  # config.around do |example|
  #   require 'rom'
  #   orginal_url = ENV['DATABASE_URL']
  #   ENV['DATABASE_URL'] = 'sqlite://./tmp/test_db.sqlite'
  #   rom = ROM.container(ROM::Configuration.new(:sql, ENV['DATABASE_URL']))
  #   rom.gateways[:default].run_migrations
  #   example.run
  # end
end

