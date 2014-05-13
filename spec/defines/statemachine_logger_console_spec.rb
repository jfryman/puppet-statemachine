require 'spec_helper'

describe "statemachine::logger::console" do
  let(:title) { 'Test Message' }

  it "should write a message to the console" do
    should contain_notify('Test Message')
  end
end
