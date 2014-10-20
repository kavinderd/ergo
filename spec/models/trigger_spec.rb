require 'rails_helper'

RSpec.describe Trigger, :type => :model do

  context "validity" do

    before(:each) do
      @attrs = { event_name: "A crazy event", user: User.new, frequency: 'daily', threshold: 1 }
    end
    
    it "is valid with all required attributes" do
      expect(Trigger.new(@attrs)).to be_valid
    end

    it "requires an event_name" do
      @attrs.delete(:event_name)
      expect(Trigger.new(@attrs)).to_not be_valid
    end

    it "requires a user" do
      @attrs.delete(:user)
      expect(Trigger.new(@attrs)).to_not be_valid
    end

    it "requires a frequency" do
      @attrs.delete(:frequency)
      expect(Trigger.new(@attrs)).to_not be_valid
    end

    it "requires a threshold" do
      @attrs.delete(:threshold)
      expect(Trigger.new(@attrs)).to_not be_valid
    end
  end
end
