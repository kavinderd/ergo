class TokensController < ApplicationController
  before_action :authenticate_user!

  def create
    # Haven't thought of a good error handling strategy yet, my bad  
    IssueToken.new.to_user(current_user)
    redirect_to root_path
  end
end
