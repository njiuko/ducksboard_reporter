require "spec_helper"
describe DucksboardReporter::Reporters::MySqlQueriesPerSecond do

  it "loads and starts" do
    expect {
      reporter = DucksboardReporter::Reporters::MySqlQueriesPerSecond.new("lala")
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
end
