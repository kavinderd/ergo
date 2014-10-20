require 'json'
class ProcessPayload

  def initialize(payload)
    @payload = parse_payload(payload)
    @next_call = @payload.delete("next_call")
  end

  def create_event
    Event.create!(@payload)
  end

  private

  def parse_payload(payload)
    JSON.parse(payload)
  end

end
