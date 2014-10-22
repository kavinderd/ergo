class Response < ActiveRecord::Base
  enum category: [ :digest, :alert, :stats, :ping]
  enum status: [:to_send, :queued, :sent, :archived]
  validates_presence_of :trigger_id, :category, :status, :start_at, :end_at, :event_name
  belongs_to :trigger, inverse_of: :responses
end
