module DucksboardReporter
  module Reporters
    class MySqlInnodbRowsReadsPerSecond < MySqlBase
      def gather_stats
        out = `mysql -e 'SHOW ENGINE INNODB STATUS\\G'`.scan(/([-+]?[0-9]*\.?[0-9]+) (reads\/s)/)
        out.nil? ? 0 : out[2][0]
      end
    end
  end
end