require "rubygems"
require "logger"
require "celluloid"
require "timers"
require "ducksboard"
require "hashie/extensions/symbolize_keys"

require "ducksboard_reporter/version"
require "ducksboard_reporter/reporter"
require "ducksboard_reporter/widget"

require "ducksboard_reporter/file_tail"
require "ducksboard_reporter/json_remote"

require "ducksboard_reporter/reporters/random"
require "ducksboard_reporter/reporters/haproxy_log_requests"
require "ducksboard_reporter/reporters/cpu_usage"
require "ducksboard_reporter/reporters/bandwidth"
require "ducksboard_reporter/reporters/honeybadger"
require "ducksboard_reporter/reporters/mysql_base"
require "ducksboard_reporter/reporters/mysql_queries_per_second"
require "ducksboard_reporter/reporters/mysql_slow_queries"
require "ducksboard_reporter/reporters/mysql_innodb_rows_reads_per_second"

Thread.abort_on_exception = true

module DucksboardReporter
  extend self

  include Celluloid::Logger

  def logger
    @logger ||= Celluloid.logger = Logger.new($stdout)
  end

  class App

    attr_reader :config, :reporters, :widgets

    def initialize(config)
      @config = symbolize_keys(config)
      register_reporters
      register_widgets
    end

    def symbolize_keys(hash)
      hash.inject({}) do |result, (key, value)|
        new_key = key.is_a?(String) ? key.to_sym : key
        new_value = case value
                    when Hash then symbolize_keys(value)
                    when Array then value.map {|v| symbolize_keys(v) }
                    else value
                    end
        result[new_key] = new_value
        result
      end
    end

    def start
      Signal.trap("INT") { exit }

      Ducksboard.api_key = config[:api_key]

      start_reporters
      start_widgets

      sleep # let the actors continue their work
    end

    def register_reporters
      @reporters = {}

      @config[:reporters].each do |config|
        reporter = Reporters.const_get(config[:type], false).new(config[:name], config[:options])
        @reporters[reporter.name] = reporter
      end
    end

    def register_widgets
      @widgets = []

      @config[:widgets].each do |config|
        reporter = @reporters.fetch(config[:reporter])

        unless reporter
          logger.error("Cannot find reporter #{config[:reporter]}")
          exit
        end

        widget = Widget.new(config[:type], config[:id], reporter, config)
        @widgets << widget
      end
    end

    def start_reporters
      @reporters.each {|_, reporter| reporter.start }
    end

    def start_widgets
      @widgets.each(&:start)
    end

    private

    def logger
      DucksboardReporter.logger
    end
  end
end
