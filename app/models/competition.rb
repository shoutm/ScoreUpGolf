class Competition < ActiveRecord::Base
  validates :name, presence: true
  validates :golf_field_id, presence: true
  validates :competition_date, presence: true
  validates :firsthalf_cource_id, presence: true
  validates :secondhalf_cource_id, presence: true
  validates :host_user_id, presence: true
end
