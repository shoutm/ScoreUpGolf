class Party < ActiveRecord::Base
  validates :party_no, presence: true
  validates :competition_id, presence: true
end
