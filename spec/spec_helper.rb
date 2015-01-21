require "ducksboard_reporter"
require "byebug"

DucksboardReporter.logger.level = Logger::FATAL

RSpec.configure do |config|
  config.color = true
end
