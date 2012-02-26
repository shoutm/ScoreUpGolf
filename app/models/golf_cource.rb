class GolfCource < ActiveRecord::Base
  belongs_to :golf_field
  has_many   :golf_holes
end
