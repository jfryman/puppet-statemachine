require 'spec_helper'

describe "statemachine::backend" do
  let(:params) {
    {
      :backend => 'statemachine::backend::local',
    }
  }

  context "load config" do
    let(:params) {
      {
        :load_config => true,
        :backend     => 'statemachine::backend::local',
      }
    }
    it "should load up the backend config" do
      should contain_statemachine__backend__local__config
    end

    it "should write the config to a file" do
      should contain_file('/etc/statemachine/backend.conf')
    end
  end
end
