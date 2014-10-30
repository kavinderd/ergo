class Client < ActiveRecord::Base
  validates_presence_of :name, :url, :user, :token
  belongs_to :user, inverse_of: :clients
end
