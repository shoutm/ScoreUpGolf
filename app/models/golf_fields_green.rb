class GolfFieldsGreen < ActiveRecord::Base
  belongs_to :golf_field
  belongs_to :green
end
