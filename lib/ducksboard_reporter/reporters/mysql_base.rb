module DucksboardReporter
  module Reporters
    class MySqlBase < Reporter

      def period
        1
      end

      def collect
        every(period) do
          update
        end
      end

      def update
        begin
          @current_stats = gather_stats
        rescue Errno::ENOENT
          error("MysqlQueriesPerSecond: failed to use mysqladmin status")
          return
        end

        self.value = @old_stats = moderated_stats
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