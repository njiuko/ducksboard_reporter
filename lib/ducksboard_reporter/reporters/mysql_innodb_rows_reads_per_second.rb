module DucksboardReporter
  module Reporters
    class MySqlInnodbRowsReadsPerSecond < MySqlBase
      def refresh_current_stats
        out = `mysql -e 'SHOW ENGINE INNODB STATUS\\G'`.scan(/([-+]?[0-9]*\.?[0-9]+) (reads\/s)/)
        out.nil? ? 0 : out
      end
    end
  end
end