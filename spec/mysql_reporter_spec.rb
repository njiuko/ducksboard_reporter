require "spec_helper"
describe DucksboardReporter::Reporters::MySqlQueriesPerSecond do
  it "loads and starts" do
    expect {
      reporter = DucksboardReporter::Reporters::MySqlQueriesPerSecond.new("lala")
      reporter.start
    }.not_to raise_error
  end
end

describe DucksboardReporter::Reporters::MySqlInnodbRowsReadsPerSecond do
  it "loads and starts" do
    expect {
      reporter = DucksboardReporter::Reporters::MySqlInnodbRowsReadsPerSecond.new("lala")
      reporter.start
    }.not_to raise_error
  end
end

describe DucksboardReporter::Reporters::MySqlSlowQueries do
  it "loads and starts" do
    expect {
      reporter = DucksboardReporter::Reporters::MySqlSlowQueries.new("lala")
      reporter.start
    }.not_to raise_error
  end

  it "calculates the delta per period correctly" do
    # example mysql status output
    # Uptime: 16076688  Threads: 174  Questions: 3193188096  Slow queries: 1235560  Opens: 2218  Flush tables: 2  Open tables: 474  Queries per second avg: 198.622
    # the way the current value is gathered:
    # `mysqladmin status`.match(/(Slow queries: )([-+]?[0-9]*\.?[0-9]+)/)
    EXAMPLE_OUT1 = "Uptime: 16076688  Threads: 174  Questions: 3193188096  Slow queries: 10  Opens: 2218  Flush tables: 2  Open tables: 474  Queries per second avg: 198.622"
    EXAMPLE_OUT2 = "Uptime: 16076688  Threads: 174  Questions: 3193188096  Slow queries: 30  Opens: 2218  Flush tables: 2  Open tables: 474  Queries per second avg: 198.622"
    EXAMPLE_OUT3 = "Uptime: 16076688  Threads: 174  Questions: 3193188096  Slow queries: 130  Opens: 2218  Flush tables: 2  Open tables: 474  Queries per second avg: 198.622"

    reporter = DucksboardReporter::Reporters::MySqlSlowQueries.new("test_reporter")

    expect_any_instance_of(reporter.class).to receive(:`).and_return(EXAMPLE_OUT1, EXAMPLE_OUT2, EXAMPLE_OUT3)
    reporter.update
    expect(reporter.value).to eq(10)
    reporter.update
    expect(reporter.value).to eq(20)
    reporter.update
    expect(reporter.value).to eq(110)

  end
end
