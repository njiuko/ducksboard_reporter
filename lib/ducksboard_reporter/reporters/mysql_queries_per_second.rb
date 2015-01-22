module DucksboardReporter
  module Reporters
    class MySqlQueriesPerSecond < MySqlBase
      def refresh_current_stats
        out = `mysqladmin status`.match(/(Queries per second avg: )([-+]?[0-9]*\.?[0-9]+)/)
        out.nil? ? 0 : out[2]
      end
    end
  end
end