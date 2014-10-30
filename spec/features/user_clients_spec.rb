require 'rails_helper'

feature "User Clients" do

  background do
    u = User.create(email: 'test@test.com', password: 'mypassword', password_confirmation: 'mypassword')
    visit '/users/sign_in'
    fill_in 'user_email', with: u.email
    fill_in 'user_password', with: 'mypassword'
    click_button 'Sign in'
  end

  scenario "Adding a new client" do
    click_link 'Add a Client'
    fill_in 'client_name', with: 'Digest Client'
    fill_in 'client_url', with: 'http://some-place.com'
    fill_in 'client_token', with: '1234567890'
    click_button 'Create'
  end

end
  
