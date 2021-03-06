# Run Coverage report
require 'simplecov'
SimpleCov.start do
  add_filter "/spec/"
end

require File.join(File.dirname(__FILE__), '../lib/products_feed')

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[File.join(File.dirname(__FILE__), 'support/**/*.rb')].each { |f| require f }

RSpec.configure do |config|
  # == Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr
  config.mock_with :rspec
  config.color = true
  config.fail_fast = ENV['FAIL_FAST'] || false
  config.order = "random"
end
