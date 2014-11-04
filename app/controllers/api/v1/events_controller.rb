module Api
  module V1
    class EventsController < ApplicationController
      before_filter :restrict_access
      skip_before_filter :verify_authenticity_token
      respond_to :json

      def create
        process = ProcessPayload.new(event_params)
        if process.create_event
          # Don't like this two step, I think a class HandleEvent or something would be better
          EventTrigger.new(process.event).trigger_responses
          render json: { message: "Event Saved" }, status: 200
        else
          render json: { message: process.errors }, status: 400
        end
      end

      private 

      def event_params
        params.require(:event).permit(:name, :count, { data: :text }, :next_call)
      end
    end
  end
end
