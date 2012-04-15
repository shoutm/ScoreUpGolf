class Competition < ActiveRecord::Base
  belongs_to :golf_field
  belongs_to :firsthalf_cource, class_name: "GolfCource"
  belongs_to :secondhalf_cource, class_name: "GolfCource"
  belongs_to :host_user, class_name: "User"
  has_many   :parties

  validates :name, presence: true
  validates :golf_field_id, presence: true
  validates :competition_date, presence: true
  validates :firsthalf_cource_id, presence: true
  validates :secondhalf_cource_id, presence: true
  validates :host_user_id, presence: true
  validates :state, presence: true
end
