module DucksboardReporter
  module Reporters
    class Random < Reporter

      def value
        rand(1000)
      end
    end
  end
end
