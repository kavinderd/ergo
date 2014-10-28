require 'rails_helper'

RSpec.describe ApiKey, :type => :model do
  
  context 'validity' do

    before(:each) do
      user = User.new
      @attrs = { user: user, token: "1234567890" }
    end

    it "is valid with all required attributes" do
      expect(ApiKey.new(@attrs)).to be_valid
    end

  end
end
