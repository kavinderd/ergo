class Trigger < ActiveRecord::Base
  enum frequency: [ :hourly, :daily, :weekly, :monthly ]
  Frequency = { hourly: 1.hour, daily: 1.day, monthly: 1.month }
  enum action: [ :digest, :alert, :status, :ping ]
  validates_presence_of :event_name, :user, :frequency, :threshold, :action
   
  belongs_to :user, inverse_of: :triggers
  has_many :responses, inverse_of: :trigger
  has_many :targetings, inverse_of: :trigger
  has_many :clients, through: :targetings

  scope :for_event, ->(event){ where("event_name = ?", event.name) }

  def send_at
    self.sent_at ? self.sent_at + frequency_time : self.created_at + frequency_time
  end

  def trigger_period
    self.sent_at ? self.sent_at : Time.now - frequency_time
  end

  def frequency_time
    Frequency[frequency.to_sym]
  end

end
