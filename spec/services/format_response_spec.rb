require "rails_helper"

RSpec.describe FormatResponse do

  context "digest responses" do

    before(:each) do
      @data = []
      10.times do |i|
        @data << double("event", data: { text: "dummy data #{i}" })
      end
    end

    it "aggregates the data of all data records" do
      fr = FormatResponse.new(@data)
      response = fr.format(:digest)
      expect(response.count).to eq(10)
      expect(response.first).to eq({text: "dummy data 0"})
    end
  end
end
