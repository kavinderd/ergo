require "rails_helper"

RSpec.describe "triggers/show" do
  let(:subject) { Trigger.new(event_name: 'Test Event', frequency: 'daily', threshold: 5, action: 'digest', clients: [Client.new(name: 'My Client')])}

  before(:each) do
    assign(:trigger, subject)
  end
  it "renders the trigger name" do
    render
    expect(rendered).to match /Test Event/
  end

  it "renders the client name" do
    render
    expect(rendered).to match /My Client/
  end

end
