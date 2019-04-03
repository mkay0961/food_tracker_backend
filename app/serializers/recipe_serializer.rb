class RecipeSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :instructions, :category, :food

  def food
    rtn = []
    self.object.recipe_foods.each_with_index do |item, i|
      obj = {}
      obj["food_id"]=item.food_id
      obj["name2"] = self.object.foods[i]["name"]
      obj["name"] = Food.find(item.food_id)["name"]
      obj["amount"] = item.amount
      rtn.push(obj)
    end

    return rtn
  end
end
