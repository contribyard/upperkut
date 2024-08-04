require 'bundler/setup'
require 'simplecov'
require 'redis'
require 'pry'
require 'upperkut'
require_relative 'helpers'


SimpleCov.start if ENV['COVERAGE'] == 'true'

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  redis = Redis.new(url: ENV['REDIS_URL'])
  config.before(:each) { redis.flushdb }

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.include Helpers
end
