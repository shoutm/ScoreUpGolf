class GolfCource < ActiveRecord::Base
  belongs_to :golf_field
  has_many   :golf_holes
  has_many   :competitions

  validates :name, presence: true
  validates :golf_field_id, presence: true
end
