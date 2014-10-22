class Trigger < ActiveRecord::Base
  enum frequency: [ :hourly, :daily, :weekly, :monthly ]
  Frequency = { hourly: 1.hour, daily: 1.day, monthly: 1.month }
  enum action: [ :digest, :alert, :status, :ping ]
  validates_presence_of :event_name, :user, :frequency, :threshold, :action
   
  belongs_to :user

  scope :for_event, ->(event){ where("event_name = ?", event.name) }

  def send_at
    time = Frequency[frequency.to_sym]
    self.sent_at ? self.sent_at + time : self.created_at + time
  end
end
