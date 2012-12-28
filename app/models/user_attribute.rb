class UserAttribute < ActiveRecord::Base
  # key names
  OPENID_FACEBOOK = "openid/facebook"
  
  belongs_to :user

  validates :key, presence: true
  validates :value, presence: true
end
