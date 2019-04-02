class RecipeSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :instructions, :catagory
  has_many :foods 
end
