module DucksboardReporter
  module Reporters
    class MySqlSlowQueries < DucksboardReporter::Reporters::MySqlBase
      def refresh_current_stats
        `mysqladmin status`.match(/(Slow queries: )(\d\.\d*)/)[2]
      end
    end
  end
end