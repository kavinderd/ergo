require 'rails_helper'

RSpec.describe HomeController, :type => :controller do

  context "GET #home" do 

    it "renders the home template" do
      get :index
      expect(response).to render_template(:index)
    end

  end

end
