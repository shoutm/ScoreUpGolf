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

  class State
    WAITING     = 10
    ARRANGED    = 20
    PLAYING     = 30
    FINISH      = 40
    ABORTED     = 50
    NOT_ARRANGED= 60
  end
end
