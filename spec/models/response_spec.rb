require 'rails_helper'
describe Response do

  context 'validity' do

    before(:each) do
      @attrs = { trigger_id: 1, category: 'digest', start_at: 1.day.ago, end_at: Time.now, event_name: 'A random event' }
    end

    it "is valid with all required attributes" do
      rp = Response.new(@attrs)
      expect(rp).to be_valid
    end
    
    it "is invalid without all required attributes" do
      @attrs.delete([:trigger_id, :category].sample)
      rp = Response.new(@attrs)
      expect(rp).to_not be_valid
    end
    
  end
end
