# frozen_string_literal: true

# This patch adds a 'with_connection' method to Proc objects
# to solve the issue with lambda expressions in tests
class Proc
  def with_connection
    ActiveRecord::Base.connection_pool.with_connection { yield call }
  end
end unless Proc.method_defined?(:with_connection)