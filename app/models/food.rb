class Food < ApplicationRecord
  has_many :recipe_foods
  belongs_to :author
end
