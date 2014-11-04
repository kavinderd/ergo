class TriggerWorker
  include Sidekiq::Worker

  def perform(trigger_id)
    @trigger = Trigger.find(trigger_id)
    return nil unless @trigger 
    count = Event.with_name(@trigger.event_name).since(@trigger.trigger_period).sum(:count)
    if triggerable?(count) && sendable?
      SendResponse.for_trigger(@trigger).send!
      @trigger.update(sent_at: Time.now)
    end
    TriggerWorker.perform_in(@trigger.frequency_time, trigger_id)
  end

  private

  def triggerable?(count)
    @trigger.threshold <= count
  end

  def sendable?
    @trigger.last_sent <= @trigger.trigger_period
  end

end
