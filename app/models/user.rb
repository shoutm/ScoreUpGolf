class User < ActiveRecord::Base
  has_many  :players
  has_many  :user_attributes
  has_many  :friend_relations, foreign_key: :user_id
  has_many  :friends, through: :friend_relations

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true
  validates :role, presence: true

  class Role
    Admin = 100
    User  = 200
  end
end
