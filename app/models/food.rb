class Food < ApplicationRecord
  has_many :recipe_foods, dependent: :destroy
  belongs_to :author, class_name: 'User'
end
