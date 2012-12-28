class User < ActiveRecord::Base
  has_many  :players
  has_many  :user_attributes

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true
  validates :role, presence: true
end
