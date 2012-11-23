class Player < ActiveRecord::Base
  belongs_to :party
  belongs_to :user
  has_many   :shot_results

  validates :party_id, presence: true
  validates :user_id, presence: true
  validates :state, presence: true

  ### DB上の定数を定義する
  class State
    WAITING     = 10
    JOINED      = 20
    FINISH      = 30
    ABSTENTION  = 40
    RETIRE      = 50
  end
end
