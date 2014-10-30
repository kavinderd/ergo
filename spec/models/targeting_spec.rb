require 'rails_helper'

RSpec.describe Targeting, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
  context "validity" do
    let(:client) { Client.new }
    let(:trigger) { Trigger.new }

    it "requires a trigger and client" do
      targeting = Targeting.new
      expect(targeting).to_not be_valid
      targeting = Targeting.new(client: client, trigger: trigger)
      expect(targeting).to be_valid
    end
  end
end
