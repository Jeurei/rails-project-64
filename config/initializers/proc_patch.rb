# frozen_string_literal: true

# This patch adds a 'with_connection' method to Proc objects
# to solve the issue with lambda expressions in tests
unless Proc.method_defined?(:with_connection)
  class Proc
    def with_connection
      ActiveRecord::Base.connection_pool.with_connection { yield call }
    end
  end
end
