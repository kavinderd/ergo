require 'rails_helper'

feature 'Creating Scenarios' do

  background do
    u = User.create(email: 'test@test.com', password: 'mypassword', password_confirmation: 'mypassword')
    c = Client.create(name: "Client #1", url: "http://some-endpoint.com", token: "1234567890", user: u, endpoint: "/events")
    c2 = Client.create(name: "Client #2", url: "http://some-endpoint.com", token: "1234567890", user: u, endpoint: "/digests")
    visit '/users/sign_in'
    fill_in 'user_email', with: u.email
    fill_in 'user_password', with: 'mypassword'
    click_button 'Sign in'
  end

  scenario 'creating a new scenario from /scenarios/new' do
    click_link 'New Trigger'
    fill_in 'trigger_event_name', with: 'Upcoming Sporting Events'
    select('daily', from: 'trigger_frequency')
    select('digest', from: 'trigger_action')
    fill_in 'trigger_threshold', with: 5
    check("Client #1")
    click_button 'Create'
    expect(page).to have_content "Upcoming Sporting Events"
  end


end
