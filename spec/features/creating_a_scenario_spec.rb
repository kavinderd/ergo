require 'rails_helper'

feature 'Creating Scenarios' do

  background do
    u = User.create(email: 'test@test.com', password: 'mypassword', password_confirmation: 'mypassword')
    visit '/users/sign_in'
    fill_in 'user_email', with: u.email
    fill_in 'user_password', with: 'mypassword'
  end

  scenario 'creating a new scenario from /scenarios/new' do
    click_button 'New Scenario'
    fill_in :event_name, with: 'Upcoming Sporting Events'
    select('daily', from: 'frequency')
    fill_in :frequency, with: 5
    select('digest', from: 'action')
  end


end
