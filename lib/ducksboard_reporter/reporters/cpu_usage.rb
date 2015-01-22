module DucksboardReporter
  module Reporters
    class CpuUsage < Reporter
      def collect
        stats = nil
        while true do
          begin
            current_stats = File.readlines("/proc/stat").grep(/\Acpu /).first.split[1,4].map(&:to_i)
          rescue Errno::ENOENT
            error("CpuUsage: Cannot open /proc/stat")
            return
          end

          sleep 1

          unless stats
            stats = current_stats
            next
          end

          proc_usage = current_stats[0,3].reduce(:+) - stats[0,3].reduce(:+)
          proc_total = current_stats.reduce(:+) - stats.reduce(:+)

          self.value = (100 * proc_usage.to_f / proc_total).round

          stats = current_stats
        end
      end
    end
  end
end
