require 'rails_helper'

RSpec.describe User, :type => :model do

  context "ApiKey association" do

    it "returns the apikey token" do
      api_key = ApiKey.new(token: "1234567890")
      user = User.new
      user.api_key = api_key
      expect(user.token).to eq("1234567890")
    end

    it "returns nil when the user has no api key" do
      user = User.new
      expect(user.token).to eq(nil)
    end

  end
 
end
