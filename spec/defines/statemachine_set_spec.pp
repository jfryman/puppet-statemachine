require "spec_helper"

describe "statemachine::set" do
  let(:title) { 'frymanet::base' }
  let(:params) {
    {
      :backend => 'statemachine::backend::local',
    }
  }

  context "no state defined" do
    it "should skip application if no state in defined" do
      should contain_statemachine__log("Unable to set state for frymanet::base. Missing state. Skipping...")
    end
  end

  context "proxy" do
    let(:params) {
      {
        :backend => 'statemachine::backend::local',
        :state   => 'ready',
      }
    }
    it "should proxy the request through to the requested resource" do
      should contain_statemachine__backend__local("frymanet::base").with({
        :base  => 'frymanet::base',
        :state => 'ready',
      })
    end
  end
end
