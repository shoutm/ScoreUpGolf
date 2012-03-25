class ShotResult < ActiveRecord::Base
  belongs_to :player
  belongs_to :golf_hole

  validates :player_id, presence: true
  validates :golf_hole_id, presence: true
  validates :shot_num, presence: true
  validates :pat_num, presence: true
end
