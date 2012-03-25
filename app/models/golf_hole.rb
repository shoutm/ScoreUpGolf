class GolfHole < ActiveRecord::Base
  belongs_to :golf_cource
  has_many   :shot_results

  validates :golf_cource_id, presence: true
  validates :hole_no, presence: true
  validates :par, presence: true
  validates :yard, presence: true
end
