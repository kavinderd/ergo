require 'rails_helper'

RSpec.describe Event, :type => :model do
  
  before(:each) do
    @attrs = { name: 'any name', count: 10, data: { text: 'hello' } }
  end

  it "requires a name" do
    @attrs.delete(:name)
    e = Event.new(@attrs)
    expect(e).to_not be_valid 
  end

  it "requires a count" do
    @attrs.delete(:count)
    e = Event.new(@attrs)
    expect(e).to_not be_valid
  end

  it "requires data" do 
    @attrs.delete(:data)
    e = Event.new(@attrs)
    expect(e).to_not be_valid
  end

  it "is valid with all attributes" do
    e = Event.new(@attrs)
    expect(e).to be_valid
  end

end
