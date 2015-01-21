module DucksboardReporter
  module Reporters
    class MySqlSlowQueries < MySqlBase
      def refresh_current_stats
        `mysqladmin status`.match(/(Slow queries: )(\d\.\d*)/)[2]
      end
    end
  end
end