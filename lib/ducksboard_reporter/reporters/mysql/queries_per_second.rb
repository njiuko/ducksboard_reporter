module DucksboardReporter
  module Reporters
    module MySql
      class QueriesPerSecond < DucksboardReporter::Reporters::MySql::Base
        def refresh_current_stats
          `mysqladmin status`.match(/(Queries per second avg: )(\d\.\d*)/)[2]
        end
      end
    end
  end
end