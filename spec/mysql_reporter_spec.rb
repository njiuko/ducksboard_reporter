require "spec_helper"
describe DucksboardReporter::Reporters::MySql::QueriesPerSecond do

  it "loads and starts" do
    expect {
      reporter = DucksboardReporter::Reporters::MySql::QueriesPerSecond.new("lala")
      reporter.start
    }.not_to raise_error
  end
end

describe DucksboardReporter::Reporters::MySql::SlowQueries do

  it "loads and starts" do
    expect {
      reporter = DucksboardReporter::Reporters::MySql::SlowQueries.new("lala")
      reporter.start
    }.not_to raise_error
  end
end
