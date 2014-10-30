require 'rails_helper'
describe SendResponse do

  before(:each) do
    @event1 = instance_double(Event, name: "A new movie", data: { text: "Star Wars Episode VII in Theaters Soon"}, created_at: 5.days.ago )
    @event2 = instance_double(Event, name: "A new movie", data: { text: "Star Wars Episode VIII in Theaters Soon" }, created_at: 3.days.ago )
    @event_dub = class_double(Event).as_stubbed_const
    client_dub = double("clients", url: "someurl.com")
    @trigger = instance_double(Trigger, event_name: "A new movie", action: 'digest', clients: [client_dub])
    @client_dub = class_double(HttpResponse).as_stubbed_const
  end

  it "collects related events for a trigger" do
    expect(Event).to receive(:with_name).and_return([@event1, @event2])
    allow(@client_dub).to receive(:post)
    rep_const = class_double(Response).as_stubbed_const
    allow(rep_const).to receive(:create)
    SendResponse.for_trigger(@trigger).send!
  end 

  it "creates responses for a trigger" do
    allow(Event).to receive(:with_name).and_return([@event1, @event2])
    allow(@client_dub).to receive(:post)
    resp_inst = instance_double(Response)
    resp = class_double(Response).as_stubbed_const
    expect(resp).to receive(:create).and_return(resp_inst)
    SendResponse.for_trigger(@trigger).send!
  end

  it "sends the response to each client of the trigger" do
    allow(Event).to receive(:with_name).and_return([@event1, @event2])
    resp_inst = instance_double(Response)
    resp = class_double(Response).as_stubbed_const
    allow(resp).to receive(:create).and_return(resp_inst)
    expect(@client_dub).to receive(:post)
    SendResponse.for_trigger(@trigger).send!
  end

end
