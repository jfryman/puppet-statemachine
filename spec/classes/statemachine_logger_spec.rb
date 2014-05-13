require 'spec_helper'

describe "statemachine::logger" do
  let(:params) {
    {
      :backend => 'statemachine::logger::console',
    }
  }

  context "load config" do
    let(:params) {
      {
        :load_config => true,
        :logger      => 'statemachine::logger::console',
      }
    }
    it "should load up the logger config" do
      should contain_statemachine__logger__console__config
    end

    it "should write the config to a file" do
      should contain_file('/etc/statemachine/logger.conf')
    end
  end
end
