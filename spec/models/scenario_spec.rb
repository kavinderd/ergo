describe Scenario do
  
  context "creating a scenario" do

    before(:each) do
      @user_dub = object_double(User.new)
      @attrs = { category: 'email_digest', threshold: 1, frequency: 'daily', event_name: "Tomorrow's Weather", user: @user_dub , action: 'email_digest'}
    end

    it "sends the create message to the Trigger class" do
      dub = class_double(Trigger)
      expect(Trigger).to receive(:create!).with({event_name: "Tomorrow's Weather", user: @user_dub, frequency: 'daily', threshold:1, action: 'email_digest'})
      Scenario.create(@attrs)
    end

  end
  
end
