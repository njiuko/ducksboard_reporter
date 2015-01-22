module DucksboardReporter
  module Reporters
    class MySqlSlowQueries < MySqlBase
      def inititialize(*args)
        @sleep_time = 60 # which time period would be good?
        super(*args)
      end

      def refresh_current_stats
        out = `mysqladmin status`.match(/(Slow queries: )([-+]?[0-9]*\.?[0-9]+)/)[2]
        out.nil? ? 0 : out
      end

      def moderate_stats(stats, current_stats)
        # in this case we want to know the delta
        current_stats - stats
      end
    end
  end
end