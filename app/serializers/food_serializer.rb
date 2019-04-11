class FoodSerializer < ActiveModel::Serializer
  attributes :id, :name, :category, :default_expiration, :unit

end
