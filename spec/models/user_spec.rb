require 'rails_helper'

RSpec.describe User, :type => :model do

  before(:each) do
    @attr = { username: 'Test Name', email: 'test@gmail.com'}
  end

  it "is valid with all attributes" do
    u = User.new(@attr)
    expect(u).to be_valid
  end

  it "requires a name" do
    @attr.delete(:username)
    u = User.new(@attr)
    expect(u).to_not be_valid
  end

  it "requires an email" do
    @attr.delete(:email)
    u = User.new(@attr)
    expect(u).to_not be_valid
  end
end
