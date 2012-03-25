class Green < ActiveRecord::Base
  has_many :golf_fields_greens

  validates :name, presence: true
end
