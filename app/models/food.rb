class Food < ApplicationRecord
  has_many :user_foods
  has_many :recipe_foods
end
