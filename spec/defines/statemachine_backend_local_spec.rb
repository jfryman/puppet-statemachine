require 'spec_helper'

describe "statemachine::backend::local" do
  let(:title) { 'frymanet::base' }
  let(:params) {
    {
      :state => 'ready',
    }
  }

  it "should write the file locally" do
    should contain_file('/etc/statemachine/states/frymanet_base').with_content(/ready/)
  end
end
