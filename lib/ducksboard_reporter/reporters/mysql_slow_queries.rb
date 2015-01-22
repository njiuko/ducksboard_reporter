module DucksboardReporter
  module Reporters
    class MySqlSlowQueries < MySqlBase

      def sleep_time
        60
      end

      def refresh_current_stats
        out = `mysqladmin status`.match(/(Slow queries: )([-+]?[0-9]*\.?[0-9]+)/)
        out.nil? ? 0 : out[1]
      end

      def moderate_stats(stats, current_stats)
        # in this case we want to know the delta
        stats = 0 if stats.nil?
        current_stats = 0 if current_stats.nil?
        current_stats.to_f - stats.to_f
      end
    end
  end
end