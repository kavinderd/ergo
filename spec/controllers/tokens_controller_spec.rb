require 'rails_helper'

RSpec.describe TokensController, :type => :controller do

  
  context "POST 'create'" do

    context "with valid attributes" do
      before(:each) do
        @user = object_double(User.new)
        request.env['warden'] = double(Warden, authenticate: @user, authenticate!: @user)
        @issue_inst = object_double(IssueToken.new)
        @issue_token = class_double(IssueToken).as_stubbed_const
      end

      it "delegates the creation to Issuetokens" do
        expect(@issue_token).to receive(:new).and_return(@issue_inst)
        expect(@issue_inst).to receive(:to_user).with(@user)
        post :create
      end

      it "redirects to the root path" do
        allow(@issue_token).to receive_message_chain(:new,:to_user)
        post :create
        expect(response).to redirect_to(root_path)
      end
    end
  end
end
