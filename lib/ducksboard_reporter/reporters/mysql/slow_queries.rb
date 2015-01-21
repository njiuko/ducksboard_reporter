module DucksboardReporter
  module Reporters
    module MySql
      class SlowQueries < DucksboardReporter::Reporters::MySql::Base
        def refresh_current_stats
          `mysqladmin status`.match(/(Slow queries: )(\d\.\d*)/)[2]
        end
      end
    end
  end
end