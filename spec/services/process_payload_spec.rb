describe ProcessPayload do
  
  context "creating events from payload"  do

    before(:each) do
      @payload = { name: "Stock Price Change", count: 1, data: { text: "This is a test" }, next_call: Time.now + 5.minutes}
    end

    it "sends to create message to Event" do
      inst = double("event", valid?: true)
      dub = class_double(Event).as_stubbed_const
      expect(dub).to receive(:create!).and_return(inst)
      ProcessPayload.new(@payload).create_event
    end

    context "with invalid attributes" do

      it "returns the errors" do
        inst = object_double(Event.new, errors: 'Some Errors', valid?: false)
        dub = class_double(Event).as_stubbed_const
        allow(dub).to receive(:create!).and_return(inst)
        p = ProcessPayload.new(@payload)
        expect(p.create_event).to eq(false)
        expect(p.errors).to eq('Some Errors')
      end

    end

  end

end
