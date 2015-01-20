module DucksboardReporter
  module Reporters
    class MysqlQueriesPerSecond < Reporter

      def collect
        stats = nil
        while true do
          begin
            current_stats = `mysqladmin status`.match(/(Queries per second avg: )(\d\.\d*)/)[2]
          rescue Errno::ENOENT
            error("MysqlQueriesPerSecond: failed to use mysqladmin status")
            return
          end

          sleep 1

          unless stats
            stats = current_stats
            next
          end

          self.value = current_stats

          stats = current_stats
        end
      end
    end
  end
end
