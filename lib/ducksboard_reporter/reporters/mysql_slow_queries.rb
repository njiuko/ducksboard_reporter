module DucksboardReporter
  module Reporters
    class MySqlSlowQueries < MySqlBase
      def refresh_current_stats
        out = `mysqladmin status`.match(/(Slow queries: )([-+]?[0-9]*\.?[0-9]+)/)[2]
        out.nil? ? 0 : out
      end
    end
  end
end