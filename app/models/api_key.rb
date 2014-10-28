class ApiKey < ActiveRecord::Base
  validates_presence_of :token, :user
  belongs_to :user, inverse_of: :api_key
 
end
