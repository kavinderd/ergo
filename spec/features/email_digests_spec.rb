require 'rails_helper'

feature 'Events Trigger Responses' do

  scenario "daily digest scenario" do
    user = User.create!(email: 'test@test.com', password: 'mypassword', password_confirmation: 'mypassword')
    scenario = Scenario.create(frequency: "daily", event_name: "Tomorrow's Weather", user: user, threshold: 1, action: 'digest')
    payload = { name: "Tomorrow's Weather", count: 1, next_call: 1.day.from_now, data: { text: "It's going to be hot" } }.to_json
    event = ProcessPayload.new(payload).create_event
    expect { EventTrigger.new(event).trigger_responses }.to change(Response, :count).by(1)
  end
end
