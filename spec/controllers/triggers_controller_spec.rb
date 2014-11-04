require 'rails_helper'

RSpec.describe TriggersController, :type => :controller do
  


  context "GET 'new'" do

    before(:each) do
      triggers= double("triggers", build: true)
      @user = object_double(User.new, triggers: triggers)
      request.env['warden'] = double(Warden, authenticate: @user, authenticate!: @user)
    end

    it "renders the new template" do
      get :new
      expect(response).to render_template(:new)
    end

    it "builds a trigger from the current user" do
      expect(@user).to receive_message_chain(:triggers, :build)
      get :new
    end

  end

  context "POST 'create'" do

    context "with valid attributes" do
      before(:each) do
        triggers= double("triggers", build: true)
        @user = object_double(User.new, triggers: triggers)
        request.env['warden'] = double(Warden, authenticate: @user, authenticate!: @user)
        @trigger_dub = stub_model(Trigger, save: true, id: 1, frequency_time: 1.day)
        @event_trigger = class_double(EventTrigger).as_stubbed_const
      end

      it "builds a trigger with the trigger params" do
        allow(@event_trigger).to receive(:perform_in).with(@trigger_dub.frequency_time, @trigger_dub.id)
        expect(@user).to receive_message_chain(:triggers, :build).and_return(@trigger_dub)
        post :create, trigger: { action: 'digest', event_name: 'some event', frequency: 'daily', threshold: 2 }
      end

      it "sends the save message to trigger" do
        allow(@event_trigger).to receive(:perform_in).with(@trigger_dub.frequency_time, @trigger_dub.id)
        allow(@user).to receive_message_chain(:triggers, :build).and_return(@trigger_dub)
        expect(@trigger_dub).to receive(:save).and_return(true)
        post :create, trigger: { action: 'digest', event_name: 'some event', frequency: 'daily', threshold: 2 }
      end

      it "redirects to @trigger" do
        allow(@event_trigger).to receive(:perform_in).with(@trigger_dub.frequency_time, @trigger_dub.id)
        allow(@user).to receive_message_chain(:triggers, :build).and_return(@trigger_dub)
        post :create, trigger: { action: 'digest', event_name: 'some event', frequency: 'daily', threshold: 2 }
        expect(response).to redirect_to(assigns(:trigger))
      end

      it "schedules a trigger job" do
        expect(@event_trigger).to receive(:perform_in).with(@trigger_dub.frequency_time, @trigger_dub.id)
        allow(@user).to receive_message_chain(:triggers, :build).and_return(@trigger_dub)
        post :create, trigger: { action: 'digest', event_name: 'some event', frequency: 'daily', threshold: 2 }
      end
    end
    
    context "with invalid attributes" do

      before(:each) do
        triggers= double("triggers", build: true)
        @user = object_double(User.new, triggers: triggers)
        request.env['warden'] = double(Warden, authenticate: @user, authenticate!: @user)
        @trigger_dub = stub_model(Trigger, save: false, id: 1)
      end

      it "renders the new template" do
        allow(@user).to receive_message_chain(:triggers, :build).and_return(@trigger_dub)
        post :create, trigger: { action: 'invalid' }
        expect(response).to render_template(:new)
      end

    end
  end

  context "GET 'show'" do
    before(:each) do
      @user = object_double(User.new)
      request.env['warden'] = double(Warden, authenticate: @user, authenticate!: @user)
      @trigger= stub_model(Trigger)
      @dub = class_double(Trigger).as_stubbed_const
    end

    it "gets the requested trigger from Trigger" do
      expect(@dub).to receive(:find).with("1").and_return(@trigger)
      get :show, id: 1
    end

    it "renders the show template" do
      allow(@dub).to receive(:find)
      get :show, id: 1
      expect(response).to render_template(:show)
    end
  end
end
