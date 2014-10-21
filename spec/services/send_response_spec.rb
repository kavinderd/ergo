describe SendResponse do

  before(:each) do
    @event1 = instance_double(Event, name: "A new movie", data: { text: "Star Wars Episode VII in Theaters Soon"} )
    @event2 = instance_double(Event, name: "A new movie", data: { text: "Star Wars Episode VIII in Theaters Soon" } )
    @event_dub = class_double(Event).as_stubbed_const
    @trigger = instance_double(Trigger, event_name: "A new movie", action: 'email_digest')
  end

  it "collects related events for a trigger" do
    expect(Event).to receive(:with_name).and_return([@event1, @event2])
    SendResponse.for_trigger(@trigger)
  end 

  it "creates responses for a trigger" do
    allow(Event).to receive(:with_name).and_return([@event1, @event2])
    resp_inst = instance_double(Response)
    resp = class_double(Response).as_stubbed_const
    expect(resp).to receive(:new).and_return(resp_inst)
    expect(resp_inst).to receive(:send!)
    SendResponse.for_trigger(@trigger)
  end

end
