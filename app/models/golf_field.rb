class GolfField < ActiveRecord::Base
  has_many :golf_cources
  has_many :golf_fields_greens
  has_many :competitions

  validates :name, presence: true
  validates :region, presence: true
end
