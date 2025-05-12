# frozen_string_literal: true

ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

# Monkey patch to add with_connection method to Proc class
# This resolves issues with lambda expressions in tests
unless Proc.method_defined?(:with_connection)
  class Proc
    def with_connection
      ActiveRecord::Base.connection_pool.with_connection { yield call }
    end
  end
end

module ActiveSupport
  class TestCase
    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)

    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all

    # Set fixture class for post_likes.yml
    set_fixture_class post_likes: Like

    # Add more helper methods to be used by all tests here...
  end
end
