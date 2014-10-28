require 'rails_helper'

describe IssueToken do

  context "issueing a new token to a user account" do

    before(:each) do
      @user_inst = object_double(User.new, token: nil)
      @class_dub = class_double(ApiKey).as_stubbed_const
    end

    it "creates a new ApiKey" do
      expect(@class_dub).to receive_message_chain(:create!, :token)
      IssueToken.new.to_user(@user_inst)
    end

    it "returns the token not the ApiKey record" do
      allow(@class_dub).to receive_message_chain(:create!, :token).and_return("1234567890")
      expect(IssueToken.new.to_user(@user_inst)).to eq("1234567890")
    end

    it "returns a token if it already exists" do
      user= object_double(User.new, token: "1234567890")
      expect(IssueToken.new.to_user(user)).to eq("1234567890")
    end

  end


end
