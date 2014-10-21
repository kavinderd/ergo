class Response

  def initialize(trigger:, events:)
    @trigger = trigger
    @events = events
  end

  def send!
    send("send_#{@trigger.action}")
  end

  private

  def send_email_digest
    text = @events.map { |e| e.data["text"] }
    ResponseMailer.email_digest(text).deliver
  end

end
