class EventTrigger 

  attr_reader :respondable_triggers
  def initialize(event)
    @event = event
  end

  def trigger_responses
    filter_respondable(Trigger.for_event(@event)).each do |trigger|
      SendResponse.for_trigger(trigger).send!
      trigger.update(sent_at: Time.now)
    end
  end

  private
  
  def filter_respondable(triggers)
    triggers.select do |trigger|
      if trigger_over_threshold?(trigger) && trigger_due?(trigger)
        trigger
      end
    end
  end

  def trigger_over_threshold?(trigger)
    trigger.threshold <= @event.count
  end

  def trigger_due?(trigger)
    @event.next_call >= trigger.send_at
  end

end
