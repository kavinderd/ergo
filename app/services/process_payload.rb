require 'json'
class ProcessPayload

  attr_reader :event
  def initialize(payload)
    @payload = payload
  end

  def create_event
    @event = Event.create!(@payload)
    @event.valid?
  end

  def errors
    @event.errors
  end

end
