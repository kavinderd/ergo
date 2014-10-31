module Api
  module V1
    class EventsController < ApplicationController
      before_filter :restrict_access
      respond_to :json

      api :POST, "/api/v1/events"
      param :token, String, required: true
      param :event, Hash, desc: "Event parameter hash" do
        param :name, String, required: true, desc: "Event name"
        param :count, Fixnum, required: true, desc: "The count of this event, >= 0"
        param :next_call, DateTime, required: true, desc: "The next time this event will be called"
        param :data, Hash, desc: "The event data" do
          param :text, String, desc: "The event data as text"
        end
      end
      error 400, "Error creating event"
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
