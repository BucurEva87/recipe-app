class Food < ApplicationRecord
  validates :name, presence: true, length: { maximum: 50,
                                             message: 'Name can not be empty' }
  has_many :recipe_foods, dependent: :destroy
  has_many :recipes, through: :recipe_foods
  belongs_to :author, class_name: 'User'
end
