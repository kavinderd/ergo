require 'rails_helper'

RSpec.describe Api::V1::EventsController, type: :controller do

  context "POST 'create'" do
    
    before(:each) do
      @payload = { name: 'Weather Change', count: "1", next_call: "2014-10-29 14:13:05 UTC", data: { text: "It't going to be 10 degrees colder tomorrow" } }.with_indifferent_access
      @processor = object_double(ProcessPayload.new(@payload),event: double("event"))
      @class_double = class_double(ProcessPayload).as_stubbed_const
      @dumb_token = object_double(ApiKey.new)
      @token= "1234567890"
      @api_double = class_double(ApiKey).as_stubbed_const
    end

    it "checks the token's validity" do
      allow(@class_double).to receive(:new).with(@payload).and_return(@processor) 
      allow(@processor).to receive(:create_event).and_return(true)
      expect(@api_double).to receive(:find_by_token).with(@token).and_return(@dumb_token)
      post :create, event: @payload, token: @token
    end

    context "with valid attributes" do

      before(:each) do
        allow(@api_double).to receive(:find_by_token).with(@token).and_return(@dumb_token)
      end

      it "initializes a ProcessPayload with the params" do
        expect(@class_double).to receive(:new).with(@payload).and_return(@processor) 
        expect(@processor).to receive(:create_event).and_return(true)
        post :create, event: @payload, token: @token
      end

      it "renders a success message with a successful save" do
        allow(@class_double).to receive(:new).with(@payload).and_return(@processor) 
        allow(@processor).to receive(:create_event).and_return(true)
        post :create, event: @payload, token: @token
        body = JSON.parse(response.body)
        expect(body["message"]).to eq("Event Saved")
      end

    end

    context "with invalid attributes" do

      before(:each) do
        allow(@class_double).to receive(:new).with(@payload).and_return(@processor) 
        allow(@processor).to receive(:create_event).and_return(false)
        allow(@api_double).to receive(:find_by_token).with(@token).and_return(@dumb_token)
      end

      it "renders the process' errors" do
        expect(@processor).to receive(:errors).and_return("something went wrong")
        post :create, event: @payload , token: @token
      end

      it "renders the process' errors" do
        allow(@processor).to receive(:errors).and_return("something went wrong")
        post :create, event: @payload, token: @token
        body = JSON.parse(response.body)
        expect(body["message"]).to eq("something went wrong")
      end

    end

  end

end
