class Event < ActiveRecord::Base
  validates_presence_of :name, :count, :data, :next_call
  scope :with_name, ->(name) { where('name = ?', name) }
  scope :since, ->(date) { where("created_at >= ?", date) }
  
end
