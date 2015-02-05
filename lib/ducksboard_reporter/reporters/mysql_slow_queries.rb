module DucksboardReporter
  module Reporters
    class MySqlSlowQueries < MySqlBase

      def sleep_time
        60
      end

      def gather_stats
        out = `mysqladmin status`.match(/(Slow queries: )([-+]?[0-9]*\.?[0-9]+)/)
        out.nil? ? 0 : out[2]
      end

      def moderated_stats
        # in this case we want to know the delta
        @current_stats.to_i - @old_stats.to_i
      end
    end
  end
end