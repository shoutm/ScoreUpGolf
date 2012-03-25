class GolfFieldsGreen < ActiveRecord::Base
  belongs_to :golf_field
  belongs_to :green

  validates :golf_field_id, presence: true
  validates :green_id, presence: true
end
