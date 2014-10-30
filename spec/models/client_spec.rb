require 'rails_helper'

RSpec.describe Client, :type => :model do

  context "validity" do

    let(:attrs) { { name: "Digest Client", url: "http://crazydigests.com", user: User.new, token: "1234567890", endpoint: "/events" }}

    it "is valid with all required attributes" do
      expect(Client.new(attrs)).to be_valid
    end

  end

end
