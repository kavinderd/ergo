require "rails_helper"
describe EventTrigger do
=begin
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
      allow(dub).to receive(:for_trigger).and_return(double("send_response", send!: true))
      EventTrigger.new(@event).trigger_responses
    end

    it "sends valid triggers to SendResponse" do
      allow(Trigger).to receive(:for_event).with(@event).and_return([@trigger, @invalid_trigger, @invalid_trigger2])
      dub = class_double(SendResponse).as_stubbed_const
      expect(dub).to receive(:for_trigger).and_return(double("send_response", send!: true))
      e = EventTrigger.new(@event)
      e.trigger_responses
    end

  end\
=end 

  context "#perform" do

    context "when a response should to be sent" do

      before(:each) do
        @event = object_double(Event.new, name: "A new movie", count: 1, next_call: 1.day.from_now)
        @event_class =class_double(Event).as_stubbed_const
        @trigger = object_double(Trigger.new, event_name: "A new movie", threshold: 1, frequency_time: 1.day, last_sent: 1.day.ago - 1.minute, update: true, trigger_period: 1.day.ago)
        @trigger_dub = class_double(Trigger).as_stubbed_const
        @send_dub = class_double(SendResponse).as_stubbed_const
      end

      it "retrieves the correct trigger" do
        expect(Trigger).to receive(:find).with(1).and_return(@trigger)
        allow(Event).to receive_message_chain(:with_name, :since, :sum).and_return(1)
        allow(SendResponse).to receive_message_chain(:for_trigger, :send!)
        EventTrigger.new.perform(1)
      end
      
      it "collects events within the triggers frequency period" do
        allow(Trigger).to receive(:find).with(1).and_return(@trigger)
        expect(Event).to receive_message_chain(:with_name, :since, :sum).and_return(1)
        allow(SendResponse).to receive_message_chain(:for_trigger, :send!)
        EventTrigger.new.perform(1)
      end

      it "delegates sending the response to SendResponse" do
        allow(Trigger).to receive(:find).with(1).and_return(@trigger)
        allow(Event).to receive_message_chain(:with_name, :since, :sum).and_return(1)
        expect(SendResponse).to receive_message_chain(:for_trigger, :send!)
        EventTrigger.new.perform(1)
      end

      it "schedules another job" do
        allow(Trigger).to receive(:find).with(1).and_return(@trigger)
        allow(Event).to receive_message_chain(:with_name, :since, :sum).and_return(1)
        allow(SendResponse).to receive_message_chain(:for_trigger, :send!)
        EventTrigger.new.perform(1)
        expect(EventTrigger).to have_enqueued_job(1)
      end

    end

    context "when the trigger does not exist" do

      before(:each) do
        @trigger_dub = class_double(Trigger).as_stubbed_const
      end

      it "doesn't schedule another job" do
        allow(Trigger).to receive(:find).with(1).and_return(nil)
        EventTrigger.new.perform(1)
        expect(EventTrigger.jobs).to eq([])
      end


    end

    



  end

end
