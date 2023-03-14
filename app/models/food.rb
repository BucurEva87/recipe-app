class Food < ApplicationRecord
  has_many :recipe_foods
  belongs_to :author, class_name: 'User'
end
