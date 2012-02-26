class GolfField < ActiveRecord::Base
  has_many :golf_cources
  has_many :golf_fields_greens
end
