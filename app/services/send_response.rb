class SendResponse

  def self.for_trigger(trigger)
    events = Event.with_name(trigger.event_name)
    self.new(trigger, events)
  end

  def initialize(trigger, events)
    @events = events
    @trigger = trigger
  end


  def send!
    record = create_response_record
    @trigger.clients.each do |client|
      HttpResponse.post(url: client.url, endpoint: client.endpoint, data: @events.last.data)
    end
  end

  private

  def create_response_record
    Response.create(trigger: @trigger, event_name: @trigger.event_name, start_at: first_event.created_at, end_at: last_event.created_at, category: @trigger.action)
  end

  def first_event
    @first_event ||= @events.first
  end

  def last_event
    @last_event ||= @events.last
  end

end
