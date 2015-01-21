require "spec_helper"

class DucksboardReporter::Reporters::FooBar < DucksboardReporter::Reporter
  attr_accessor :log_file
end

describe DucksboardReporter::App do
  let(:config) { YAML.load_file(File.expand_path("../config.yml", __FILE__)) }
  let(:app) { DucksboardReporter::App.new(config) }
  let(:reporter) { app.reporters["foo_bar"] }
  let(:widget) { app.widgets.first }

  it "registers reporters from config" do
    expect(app.reporters.values.map(&:class)).to include(DucksboardReporter::Reporters::FooBar)
  end

  it "registers widgets from config" do
    expect(app.widgets.map(&:class)).to include(DucksboardReporter::Widget)
  end

  describe "single reporter" do

    it "sets name from config" do
      expect(reporter.name).to eq("foo_bar")
    end

    it "applies options to reporters" do
      expect(reporter.options[:log_file]).to eq("/var/log/haproxy.log")
    end
  end

  describe "single widget" do

    it "sets id from config" do
      expect(widget.id).to eq(123123)
    end

    it "references reporter" do
      expect(widget.reporter).to eq(reporter)
    end
  end
end

