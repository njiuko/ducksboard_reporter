module DucksboardReporter
  module Reporters
    class MySqlBase < Reporter
      def collect
        stats = nil
        
        while true do
          begin
            current_stats = refresh_current_stats
          rescue Errno::ENOENT
            error("MysqlQueriesPerSecond: failed to use mysqladmin status")
            return
          end

          sleep sleep_time

          unless stats
            stats = moderate_stats(current_stats)
            next
          end

          self.value = stats = moderate_stats(current_stats)
        end
      end

      def moderate_stats(stats, current_stats)
        # default is to just take the absolute value
        current_stats
      end

      def refresh_current_stats
        raise NotImplementedError
      end
    end
  end
end