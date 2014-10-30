class Client < ActiveRecord::Base
  validates_presence_of :name, :url, :user, :token, :endpoint
  belongs_to :user, inverse_of: :clients
  has_many :targetings, inverse_of: :client
  has_many :triggers, through: :targetings
end
