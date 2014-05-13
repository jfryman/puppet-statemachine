require 'spec_helper'

describe "statemachine" do
  let(:title) { 'frymanet::base' }
  context "initialize" do
    it "should initialize the first state if it has not been set" do
      should contain_statemachine__log("Initializing statemachine frymanet::base to provisioning")
      should contain_statemachine__set("initialize frymanet::base with default value: provisioning").with({
        "base"  => 'frymanet::base',
        "state" => 'provisioning',
      })
    end

    context "bad base name" do
      let(:title) { 'frymanet::base99999' }
      it "should reject invalid bases" do
        should contain_statemachine__log('frymanet::base99999 contains invalid characters. See README.md for more information. Ignoring...')
      end
    end
  end

  context "set state" do
    context "unknown state" do
      let(:facts) {
        {
          "statemachine_frymanet_base" => 'fakestate',
        }
      }
      it "should skip an unknown state" do
        should contain_statemachine__log("In a weird place. Not in a known state (frymanet::base/fakestate). Skipping...")
      end
    end

    context "undefined manifest" do
      let(:facts) {
        {
          "statemachine_frymanet_base" => 'fakestate',
        }
      }

      let(:params) {
        {
          "states" => %w{provisioning config ready fakestate}
        }
      }
      it "should fail open if the requested state has not been defined" do
        pending
        should contain_statemachine__log("frymanet::base::state::fakestate has not been defined. Skipping...")
      end
    end

    context "all valid" do
      let(:facts) {
        {
          "statemachine_frymanet_base" => 'ready',
        }
      }

      it "should load up the state if it exists and has been defined" do
        should contain_statemachine__log('Activating state frymanet::base::state::ready.')
        should contain_frymanet__base__state__ready
      end
    end
  end
end
