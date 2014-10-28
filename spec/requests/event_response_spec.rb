require 'rails_helper'

RSpec.describe 'Events Trigger Responses' do

  it "creates a response from an API event" do
    user = User.create!(email: 'test@test.com', password: 'mypassword', password_confirmation: 'mypassword')
    api_token = IssueToken.new.to_user(user)
    scenario = Trigger.create!(frequency: "daily", event_name: "Tomorrow's Weather", user: user, threshold: 1, action: 'digest')
    payload = { name: "Tomorrow's Weather", count: 1, next_call: 1.day.from_now, data: { text: "It's going to be hot" } }.to_json
    expect { post "api/v1/events", { token: api_token, event: payload} }.to change(Response, :count).by(1)
  end


end
