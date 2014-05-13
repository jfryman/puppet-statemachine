require "spec_helper"

describe "statemachine::log" do
  let(:title) { 'Test Message' }
  let(:params) {
    {
      :logger => 'statemachine::logger::console',
    }
  }

  context "no state defined" do
    it "should skip application if no state in defined" do
      should contain_notify("[statemachite] Missing base. Skipping...")
    end
  end

  context "proxy" do
    let(:params) {
      {
        :logger => 'statemachine::logger::console',
        :base   => 'frymanet::base',
      }
    }
    it "should proxy the request through to the requested resource" do
      should contain_statemachine__logger__console("Test Message")
    end
  end
end
