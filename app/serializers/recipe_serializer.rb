class RecipeSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :instructions, :category, :food

  def food
    rtn = []
    self.object.recipe_foods.each_with_index do |item, i|
      obj = {}
      aFood = Food.find(item.food_id)
      obj["food_id"]=item.food_id
      obj["name"] = aFood["name"]
      obj["unit"] = aFood["unit"]
      obj["amount"] = item.amount
      rtn.push(obj)
    end
    return rtn
  end

end
