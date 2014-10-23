class TriggersController < ApplicationController
  before_action :authenticate_user!

  def new
    @trigger = current_user.triggers.build  
  end

  def create
    @trigger = current_user.triggers.build(trigger_params)
    if @trigger.save
      redirect_to @trigger
    else
      render :new
    end
  end

  def show
    @trigger = Trigger.find(params[:id])
  end

  private

  def trigger_params
    params.require(:trigger).permit(:event_name, :frequency, :action, :threshold)
  end

end
