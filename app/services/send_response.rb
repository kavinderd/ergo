class SendResponse

  def self.for_trigger(trigger)
    events = Event.with_name(trigger.event_name)
    Response.new(trigger: trigger, events: events).send!
  end

end
