module DucksboardReporter
  module Reporters
    class MySqlSlowQueries < MySqlBase

      def period
        60
      end

      def gather_stats
        out = `mysqladmin status`.match(/(Slow queries: )([-+]?[0-9]*\.?[0-9]+)/)
        out.nil? ? 0 : out[2]
      end

      def moderated_stats
        # in this case we want to know the delta
        delta = @current_stats.to_i - @old_stats.to_i
        @old_stats = @current_stats
        debug(log_format("old: #{@old_stats}, current: #{@current_stats}, delta: #{delta}, thread id: #{Thread.current.object_id}"))
        delta
      end
    end
  end
end