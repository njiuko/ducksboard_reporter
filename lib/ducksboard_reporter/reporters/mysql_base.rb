module DucksboardReporter
  module Reporters
    class MySqlBase < Reporter

      def sleep_time
        1
      end

      def collect
        @old_stats ||= 0
        @current_stats ||= 0

        while true do
          begin
            @current_stats = gather_stats
          rescue Errno::ENOENT
            error("MysqlQueriesPerSecond: failed to use mysqladmin status")
            return
          end

          if @old_stats == 0
            @old_stats = moderated_stats
            next
          end

          self.value = @old_stats = moderated_stats
          sleep sleep_time
        end
      end

      def moderate_stats
        # default is to just take the absolute value
        @current_stats
      end

      def gather_stats
        raise NotImplementedError
      end
    end
  end
end