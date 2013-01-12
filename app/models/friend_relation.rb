class FriendRelation < ActiveRecord::Base
  belongs_to :user
  belongs_to :friend, class_name: "User", foreign_key: :friend_id

  validates :user_id, presence: true
  validates :friend_id, presence: true

  class State 
    REQUESTING   = 10
    BE_REQUESTED = 20
    BE_FRIENDS   = 30
    BREAKED_OFF  = 40
    DENIED       = 50
  end
end
