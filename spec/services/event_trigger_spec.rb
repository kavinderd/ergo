describe EventTrigger do

  context "triggering a daily action" do

    before(:each) do
      @event = instance_double(Event, name: "A new movie", count: 1, next_call: 1.day.from_now)
      @trigger = instance_double(Trigger, event_name: "A new movie", threshold: 1, action: "email_alert", frequency: "daily", send_at: Time.now, update: true)
      @invalid_trigger = instance_double(Trigger, event_name: "A new movie", threshold: 2, action: "email_alert", frequency: "daily", send_at: 1.day.from_now + 1.minute)
      @invalid_trigger2 = instance_double(Trigger, event_name: "A new movie", threshold: 1, action: "email_alert", frequency: "weekly", send_at: 3.days.from_now)

      @trigger_dub = class_double(Trigger).as_stubbed_const
    end

    it "collects all triggers related to event" do
      expect(Trigger).to receive(:for_event).with(@event).and_return([@trigger])
      dub = class_double(SendResponse).as_stubbed_const
      allow(dub).to receive(:for_trigger)
      EventTrigger.new(@event).trigger_responses
    end

    it "sends valid triggers to SendResponse" do
      allow(Trigger).to receive(:for_event).with(@event).and_return([@trigger, @invalid_trigger, @invalid_trigger2])
      dub = class_double(SendResponse).as_stubbed_const
      expect(dub).to receive(:for_trigger).with(@trigger).and_return(true)
      e = EventTrigger.new(@event)
      e.trigger_responses
    end

  end

  

end
