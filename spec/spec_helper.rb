

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
end

require 'rake'
load File.expand_path(File.dirname(__FILE__) + '/../Rakefile')
RSpec.configure do |config|
  config.around do |example|
    orginal_url = ENV['DATABASE_URL']
    ENV['DATABASE_URL'] = 'sqlite::memory:'
    Rake::Task['db:reset'].invoke
    example.run
    ENV['DATABASE_URL'] = orginal_url
  end
end

require_relative '../lib/application'
