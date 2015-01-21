require "ducksboard_reporter"

DucksboardReporter.logger.level = Logger::FATAL

RSpec.configure do |config|
  config.color = true
end
