require 'json'
class ProcessPayload

  attr_reader :event
  def initialize(payload)
    @payload = payload
  end

  def create_event
    @event = Event.new(@payload)
    @event.save
  end

  def errors
    @event.errors
  end

end
