class Trigger < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :event_name, :user, :frequency, :threshold
end
