class RecipeSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :instructions, :category
  has_many :foods
end
