require 'rails_helper'

RSpec.describe "home/index" do

  context 'when user is signed in' do
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      user = User.create(email: 'test@test.com', password: 'mypassword', password_confirmation: 'mypassword')
      sign_in user
    end

    it "renders the dashboard partial" do
      render
      expect(rendered).to match /Dashboard/
    end

    it "has a link to creating a new scenario" do
      render
      expect(rendered).to match /New Trigger/
    end
  end

  context "without being signed in" do

    it "renders the public_home partial" do
      render
      expect(rendered).to match /Sign In/
      expect(rendered).to match /Sign Up/
    end
  end

  
end
