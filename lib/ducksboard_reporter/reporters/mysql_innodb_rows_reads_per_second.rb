module DucksboardReporter
  module Reporters
    class MySqlInnodbRowsReadsPerSecond < MySqlBase
      def refresh_current_stats
        out = `mysql -e 'SHOW ENGINE INNODB STATUS\\G' |grep 'reads/s'`.match(/(reads\/s)/)[2]
        out.nil? ? 0 : out
      end
    end
  end
end