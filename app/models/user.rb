class User < ApplicationRecord
  has_many :user_foods
  has_many :foods, through: :user_foods
  has_many :user_recipes
  has_many :recipes, through: :user_recipes
end
