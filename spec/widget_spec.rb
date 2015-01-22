require "spec_helper"

class WidgetReporter < DucksboardReporter::Reporter
  def value
    23
  end

  def other_value
    99
  end
end

describe DucksboardReporter::Widget do

  let(:reporter) { WidgetReporter.new("name") }
  let(:widget) { DucksboardReporter::Widget.new("Box", 1234, reporter) }
  let(:ruby_version) { RUBY_VERSION.split(".")[0].to_i }

  describe "#update" do
    it "updates value from reporter" do
      expect(widget.updater).to receive(:update).with(23)
      widget.update
    end

    it "will not crash on Net::ReadTimeout" do
      if ruby_version >= 2
        expect(widget.updater).to receive(:update).and_raise(Net::ReadTimeout)
      end

      if ruby_version < 2
        expect(widget.updater).to receive(:update).and_raise(TimeoutError)
      end
      widget.update
    end

    it "will not crash on Net::OpenTimeout" do
      if ruby_version >= 2
        expect(widget.updater).to receive(:update).and_raise(Net::OpenTimeout)
      end

      if ruby_version < 2
        expect(widget.updater).to receive(:update).and_raise(TimeoutError)
      end
      widget.update
    end

    it "will not crash on Errno::ECONNRESET" do
      expect(widget.updater).to receive(:update).and_raise(Errno::ECONNRESET)
      widget.update
    end

    it "uses static values for update" do
      widget = DucksboardReporter::Widget.new("Box", 1234, reporter, value: "hello")
      expect(widget.updater).to receive(:update).with("hello")
      widget.update
    end

    it "uses Symbols for method reference" do
      widget = DucksboardReporter::Widget.new("Box", 1234, reporter, value: :other_value)
      expect(widget.updater).to receive(:update).with(99)
      widget.update
    end

    it "uses a Hash for contructing complex values " do
      widget = DucksboardReporter::Widget.new("Box", 1234, reporter, value: {current: :value, foo: "bar"})
      expect(widget.updater).to receive(:update).with(current: 23, foo: "bar")
      widget.update
    end
  end

  describe "#interval" do
    it "retuns default value" do
      expect(widget.interval).to eq(10)
    end

    it "returns interval option" do
      widget = DucksboardReporter::Widget.new("Box", 1234, reporter, interval: 20)
      expect(widget.interval).to eq(20)
    end
  end

  describe "#start" do
    it "calls update every interval" do
      widget = DucksboardReporter::Widget.new("Box", 1234, reporter, interval: 0.001)
      expect(widget.updater).to receive(:update).at_least(:once)
      widget.start
      sleep 0.002
    end
  end
end

