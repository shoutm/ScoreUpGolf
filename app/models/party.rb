class Party < ActiveRecord::Base
  belongs_to :competition
  has_many   :players

  validates :party_no, presence: true
  validates :competition_id, presence: true
end
