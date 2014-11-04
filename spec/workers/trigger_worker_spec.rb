require "rails_helper"
describe TriggerWorker do

  context "#perform" do

    context "when a response should to be sent" do

      before(:each) do
        @event = object_double(Event.new, name: "A new movie", count: 1) 
        @event_class =class_double(Event).as_stubbed_const
        @trigger = object_double(Trigger.new, event_name: "A new movie", threshold: 1, frequency_time: 1.day, last_sent: 1.day.ago - 1.minute, update: true, trigger_period: 1.day.ago)
        @trigger_dub = class_double(Trigger).as_stubbed_const
        @send_dub = class_double(SendResponse).as_stubbed_const
      end

      it "retrieves the correct trigger" do
        expect(Trigger).to receive(:find).with(1).and_return(@trigger)
        allow(Event).to receive_message_chain(:with_name, :since, :sum).and_return(1)
        allow(SendResponse).to receive_message_chain(:for_trigger, :send!)
        TriggerWorker.new.perform(1)
      end
      
      it "collects events within the triggers frequency period" do
        allow(Trigger).to receive(:find).with(1).and_return(@trigger)
        expect(Event).to receive_message_chain(:with_name, :since, :sum).and_return(1)
        allow(SendResponse).to receive_message_chain(:for_trigger, :send!)
        TriggerWorker.new.perform(1)
      end

      it "delegates sending the response to SendResponse" do
        allow(Trigger).to receive(:find).with(1).and_return(@trigger)
        allow(Event).to receive_message_chain(:with_name, :since, :sum).and_return(1)
        expect(SendResponse).to receive_message_chain(:for_trigger, :send!)
        TriggerWorker.new.perform(1)
      end

      it "schedules another job" do
        allow(Trigger).to receive(:find).with(1).and_return(@trigger)
        allow(Event).to receive_message_chain(:with_name, :since, :sum).and_return(1)
        allow(SendResponse).to receive_message_chain(:for_trigger, :send!)
        TriggerWorker.new.perform(1)
        expect(TriggerWorker).to have_enqueued_job(1)
      end

    end

    context "when the trigger does not exist" do

      before(:each) do
        @trigger_dub = class_double(Trigger).as_stubbed_const
      end

      it "doesn't schedule another job" do
        allow(Trigger).to receive(:find).with(1).and_return(nil)
        TriggerWorker.new.perform(1)
        expect(TriggerWorker.jobs).to eq([])
      end


    end
  end

end
