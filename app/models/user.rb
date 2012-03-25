class User < ActiveRecord::Base
  has_many  :players

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true
  validates :role, presence: true
end
