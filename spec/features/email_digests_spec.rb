require 'rails_helper'

feature 'Email Digests' do

  scenario "sending an email digest for a single daily event" do
    user = User.create(username: 'test_user', email: 'test@test.com')
    scenario = Scenario.create(frequency: "daily", event_name: "Tomorrow's Weather", user: user, threshold: 1, action: 'digest')
    payload = { name: "Tomorrow's Weather", count: 1, next_call: 1.day.from_now, data: { text: "It's going to be hot" } }.to_json
    event = ProcessPayload.new(payload).create_event
    expect { EventTrigger.new(event).trigger_responses }.to change(ActionMailer::Base.deliveries, :count).by(1)
  end
end
