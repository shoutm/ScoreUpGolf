class GolfField < ActiveRecord::Base
  has_many :golf_cources
  has_many :golf_fields_greens

  validates :name, presence: true
  validates :region, presence: true
end
