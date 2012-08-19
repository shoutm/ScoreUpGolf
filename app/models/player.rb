class Player < ActiveRecord::Base
  belongs_to :party
  belongs_to :user
  has_many   :shot_results

  validates :party_id, presence: true
  validates :user_id, presence: true
  validates :state, presence: true
end
