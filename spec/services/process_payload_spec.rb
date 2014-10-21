describe ProcessPayload do
  
  context "creating events from payload"  do

    before(:each) do
      @payload = { name: "Stock Price Change", count: 1, data: { text: "This is a test" }, next_call: Time.now + 5.minutes}.to_json
    end

    it "sends to create message to Event" do
      dub = class_double(Event).as_stubbed_const
      expect(dub).to receive(:create!)
      ProcessPayload.new(@payload).create_event
    end

  end

end
