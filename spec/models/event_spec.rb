require 'rails_helper'

RSpec.describe Event, :type => :model do
  
  before(:each) do
    @attrs = { name: 'any name', count: 10, data: { text: 'hello' } , next_call: 1.day.from_now}
  end

  it "is valid with all attributes" do
    e = Event.new(@attrs)
    expect(e).to be_valid
  end

end
