require "rails_helper"

feature "Api Tokens" do

  background do
    u = User.create(email: 'test@test.com', password: 'mypassword', password_confirmation: 'mypassword')
    visit '/users/sign_in'
    fill_in 'user_email', with: u.email
    fill_in 'user_password', with: 'mypassword'
    click_button 'Sign in'
  end

  scenario "Creating a new token" do
    expect(page).not_to have_content("Your Api Token")
    click_button "Get Api Token"
    expect(page).to have_content "Api Token: "
    expect(page).not_to have_content "Get Api Token"
  end

end
