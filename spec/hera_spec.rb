require 'spec_helper'
describe Hera do
  it "#test returns a successful message" do
    expect(Hera.test).to eq("Successful")
  end
end
