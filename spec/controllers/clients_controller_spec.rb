require 'rails_helper'

RSpec.describe ClientsController, :type => :controller do

  context "GET 'new'" do

    before(:each) do
      clients = double("client", build: true)
      @user = object_double(User.new, clients: clients)
      request.env['warden'] = double(Warden, authenticate: @user, authenticate!: @user)
    end

    it "renders the new template" do
      get :new
      expect(response).to render_template(:new)
    end

    it "builds a client from the current user" do
      expect(@user).to receive_message_chain(:clients, :build)
      get :new
    end

  end

  context "POST 'create'" do

    context "with valid attributes" do
      before(:each) do
        clients= double("clients", build: true)
        @user = object_double(User.new, clients: clients)
        request.env['warden'] = double(Warden, authenticate: @user, authenticate!: @user)
        @client_dub = stub_model(Client, save: true, id: 1)
      end

      it "builds a client with the client params" do
        expect(@user).to receive_message_chain(:clients, :build).and_return(@client_dub)
        post :create, client: { name: 'My Client', url: 'http://www.awebsite/', token: "123456789" }
      end

      it "sends the save message to client" do
        allow(@user).to receive_message_chain(:clients, :build).and_return(@client_dub)
        expect(@client_dub).to receive(:save).and_return(true)
        post :create, client: { name: 'My Client', url: 'http://www.awebsite/', token: "123456789" }
      end

      it "redirects to @client" do
        allow(@user).to receive_message_chain(:clients, :build).and_return(@client_dub)
        post :create, client: { name: 'My Client', url: 'http://www.awebsite/', token: "123456789" }
        expect(response).to redirect_to(assigns(:client))
      end
    end
    
    context "with invalid attributes" do

      before(:each) do
        clients= double("clients", build: true)
        @user = object_double(User.new, clients: clients)
        request.env['warden'] = double(Warden, authenticate: @user, authenticate!: @user)
        @client_dub = stub_model(Client, save: false, id: 1)
      end

      it "renders the new template" do
        allow(@user).to receive_message_chain(:clients, :build).and_return(@client_dub)
        post :create, client: { name: 'My Client' }
        expect(response).to render_template(:new)
      end

    end
  end

  context "GET 'show'" do
    before(:each) do
      @user = object_double(User.new)
      request.env['warden'] = double(Warden, authenticate: @user, authenticate!: @user)
      @client= stub_model(Client)
      @dub = class_double(Client).as_stubbed_const
    end

    it "gets the requested client from Client" do
      expect(@dub).to receive(:find).with("1").and_return(@client)
      get :show, id: 1
    end

    it "renders the show template" do
      allow(@dub).to receive(:find)
      get :show, id: 1
      expect(response).to render_template(:show)
    end
  end

end
