module DucksboardReporter
  module Reporters
    class MySqlQueriesPerSecond < MySqlBase
      def refresh_current_stats
        `mysqladmin status`.match(/(Queries per second avg: )(\d\.\d*)/)[2]
      end
    end
  end
end