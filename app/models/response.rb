class Response

  def initialize(trigger:, events:)
    @trigger = trigger
    @events = events
  end

  def send!
    send("send_#{@trigger.action}")
  end

  private

  def send_digest
    text = @events.map { |e| e.data["text"] }
  end

end
