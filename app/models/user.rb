class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, :confirmable

  has_many :inventories, foreign_key: :author_id
  has_many :recipes, foreign_key: :author_id
  has_many :foods
end
