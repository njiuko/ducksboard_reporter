module DucksboardReporter
  module Reporters
    module MySql
      class Base < Reporter

        def collect
          stats = nil
          while true do
            begin
              current_stats = refresh_current_stats
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

        def refresh_current_stats
          raise NotImplementedError
        end
      end
    end
  end
end