class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, :confirmable

  has_many :inventories, foreign_key: :author_id
  has_many :authored_recipes, class_name: 'Recipe', foreign_key: :author_id
  has_many :authored_foods, class_name: 'Food', foreign_key: :author_id
end
