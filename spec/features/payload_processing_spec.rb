# Trying to write these acceptance tests in Gary Bernhardt's style, without needing to actually interface with the webapp itself.
require 'rails_helper'
feature "Payload Requests" do

  scenario "creating events from payloads" do
    payload = { name: 'Weather Change', count: 1, data: { text: "It't going to be 10 degrees colder tomorrow" } }
    expect do 
      ProcessPayload.new(payload).create_event
    end.to change(Event, :count).by(1)
  end

end
