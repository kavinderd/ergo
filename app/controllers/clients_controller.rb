class ClientsController < ApplicationController
  before_action :authenticate_user!

  def new
    @client = current_user.clients.build
  end

  def create
    @client = current_user.clients.build(client_params)
    if @client.save
      redirect_to @client
    else
      render :new
    end
  end

  def show
    @client = Client.find(params[:id])
  end

  private

  def client_params
    params.require(:client).permit(:name, :url, :token, :endpoint)
  end
end
