require 'rails_helper'

RSpec.describe Trigger, :type => :model do

  context "validity" do

    before(:each) do
      @attrs = { event_name: "A crazy event", user: User.new, frequency: 'daily', threshold: 1 , action: 'email_digest'}
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

    it "requires an action" do
      @attrs.delete(:action)
      expect(Trigger.new(@attrs)).to_not be_valid
    end

    it "only allows a valid frequency" do
      @attrs[:frequency] = "random"
      expect { Trigger.new(@attrs)}.to raise_error(ArgumentError)
    end

    it "only allows a valid action" do
      @attrs[:action] = "random"
      expect { Trigger.new(@attrs) }.to raise_error(ArgumentError)
    end

  end
  context "send_at" do

    before(:each) do
      @attrs = { event_name: "A crazy event", user: User.new, frequency: 'daily', threshold: 1 , action: 'email_digest'}
    end

    it "is based on created_at when sent_at is blank" do
      t = Trigger.create!(@attrs)
      expect(t.send_at).to eq(t.created_at + 1.day)
    end

    it "is based on sent_at when sent_at is not blank" do
      t = Trigger.create!(@attrs)
      t.sent_at = 1.day.from_now
      expect(t.send_at).to eq(t.sent_at + 1.day)
    end
  end

end
