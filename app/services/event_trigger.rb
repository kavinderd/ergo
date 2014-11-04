class EventTrigger 
  include Sidekiq::Worker

  def perform(trigger_id)
    @trigger = Trigger.find(trigger_id)
    count = Event.with_name(@trigger.event_name).since(@trigger.trigger_period).sum(:count)
    if triggerable?(count) && sendable?
      SendResponse.for_trigger(@trigger).send!
      @trigger.update(sent_at: Time.now)
    end
    EventTrigger.perform_in(@trigger.frequency_time, trigger_id)
  end

  private

  def triggerable?(count)
    @trigger.threshold <= count
  end

  def sendable?
    @trigger.last_sent <= @trigger.trigger_period
  end

end
