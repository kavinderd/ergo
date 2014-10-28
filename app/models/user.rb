class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :triggers, inverse_of: :user
  has_one :api_key, inverse_of: :user

  def token
    api_key.token if api_key
  end

end
