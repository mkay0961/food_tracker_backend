class UserSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :email, :profile_image, :foods
  has_many :recipes

  def foods
    rtn = []
    self.object.user_foods.each_with_index do |item, i|
      obj = {}
      food = Food.find(item.food_id)
      obj["food_id"]=item.food_id
      obj["name"] = food["name"]
      obj["category"] = food["category"]
      obj["amount"] = item["amount"]
      rtn.push(obj)
    end
    return rtn
  end
end
