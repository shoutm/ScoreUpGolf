class Player < ActiveRecord::Base
  validates :party_id, presence: true
  validates :user_id, presence: true
end
