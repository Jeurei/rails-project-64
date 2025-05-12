# frozen_string_literal: true

unless Proc.method_defined?(:with_connection)
  class Proc
    def with_connection
      ActiveRecord::Base.connection_pool.with_connection { yield call }
    end
  end
end
