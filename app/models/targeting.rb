class Targeting < ActiveRecord::Base
  validates_presence_of :client, :trigger
  belongs_to :client
  belongs_to :trigger
end
