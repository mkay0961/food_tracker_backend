class User < ApplicationRecord
  has_many :user_foods
  has_many :foods, through: :user_foods
  has_many :user_recipes
  has_many :recipes, through: :user_recipes
  has_secure_password
  validates :username, uniqueness: { case_sensitive: false }


  def genUser()
    newUser = {}
    newUser["id"] = self.id
    newUser["username"] = self.username
    newUser["password_digest"] = self.password_digest
    newUser["first_name"] = self.first_name
    newUser["last_name"] = self.last_name
    newUser["email"] = self.email
    newUser["profile_image"] = self.profile_image
    newUser["foods"] = genFoods(self)
    newUser["recipes"] = genRecipes(self)
    return newUser
  end

  def genRecipes(user)
    rtn = []
    user.recipes.each do |recipe|
      recipeObj = {}
      recipeObj["id"] = recipe.id
      recipeObj["title"] = recipe.title
      recipeObj["description"] = recipe.description
      recipeObj["instructions"] = recipe.instructions
      recipeObj["category"] = recipe.category
      recipeObj["food"] = []
      recipe.recipe_foods.each_with_index do |item, i|
        foodObj = {}
        foodObj["food_id"]=item.food_id
        foodObj["name"] = Food.find(item.food_id)["name"]
        foodObj["amount"] = item.amount
        recipeObj["food"].push(foodObj)
      end
      rtn.push(recipeObj)
    end
    return rtn
  end

  def genFoods(user)
    rtn = []
    user.user_foods.each_with_index do |item, i|
      obj = {}
      food = Food.find(item.food_id)
      obj["food_id"] = item.food_id
      obj["name"] = food["name"]
      obj["category"] = food["category"]
      obj["amount"] = item["amount"]
      rtn.push(obj)
    end
    return rtn
  end
  
end
