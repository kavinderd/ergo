require 'rails_helper'

feature 'Email Digests' do

  scenario "sending an email digest for a single daily event" do
    user = User.create(username: 'test_user', email: 'test@test.com')
    scenario = Scenario.create(category: "email_digest", frequency: "daily", event_name: "Tomorrow's Weather", user: user, threshold: 1)
    payload = { name: "Tomorrow's Weather", count: 1, next_call: 1.day.from_now, data: { text: "It's going to be hot" } }.to_json
    resp = ProcessPayload.new(payload).process!
    expect(resp.user).to eq(user)
    expect(resp.status).to eq(:sent)
  end
end
