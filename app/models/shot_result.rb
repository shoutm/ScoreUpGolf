class ShotResult < ActiveRecord::Base
  validates :player_id, presence: true
  validates :hole_id, presence: true
  validates :shot_num, presence: true
  validates :pat_num, presence: true
end
