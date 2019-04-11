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
        food = Food.find(item.food_id)
        foodObj["food_id"]=item.food_id
        foodObj["name"] = food["name"]
        foodObj["unit"] = food["unit"]
        foodObj["amount"] = item.amount
        recipeObj["food"].push(foodObj)
      end
      rtn.push(recipeObj)
    end
    return rtn
  end

  def genFoods(user)
    rtn = []
    ids = []

    user.user_foods.each_with_index do |item, i|
      # foodObj = {}
      # dopObj = {}
      food = Food.find(item.food_id)
      puts item.nil?
      if (ids.include?(item.food_id))
        dopObj = {}
        rtn.each do |item2|
          if(item.food_id == item2["food_id"])
            dopObj["user_food_id"] = item.id
            dopObj["amount"] = item["amount"]
            dopObj["expiration_date"] = item["expiration_date"]
            dopObj["price"] = item["price"]
            dopObj["expired"] = item["expired"]
            item2["specific_instances"].push(dopObj)
          end
        end

      else
        foodObj = {}
        dopObj = {}
        foodObj["specific_instances"] = []
        foodObj["food_id"] = item.food_id
        foodObj["name"] = food["name"]
        foodObj["unit"] = food["unit"]
        foodObj["category"] = food["category"]
        # foodObj["combined_amount"] = "UPDATE ME"
        dopObj["user_food_id"] = item.id
        dopObj["amount"] = item["amount"]
        dopObj["expired"] = item["expired"]
        dopObj["expiration_date"] = item["expiration_date"]
        foodObj["specific_instances"].push(dopObj)
        rtn.push(foodObj)
      end

      ids.push(item.food_id)

    end
    # byebug

    rtn.each do |item3|
      puts item3["specific_instances"].length
      if item3["specific_instances"].length.to_i > 1
        total = 0
        unit = item3["unit"]
        item3["specific_instances"].each do |item4|
          total += item4["amount"].split(" ")[0].to_i
        end
        item3["combined_amount"] = total.to_s + " " + unit
      else
        item3["combined_amount"] = item3["specific_instances"][0]["amount"]
      end
    end
    puts "array"
    puts rtn
    puts "array"

    return rtn
  end

end
