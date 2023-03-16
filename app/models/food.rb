class Food < ApplicationRecord
  has_many :recipe_foods, dependent: :destroy
  belongs_to :author, class_name: 'User'
  validates :name, presence: true, length: { maximum: 50,
                                             message: 'Name can not be empty' }
end
