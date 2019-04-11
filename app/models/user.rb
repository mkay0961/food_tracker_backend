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
    newUser["foods"] = genFoods()
    newUser["recipes"] = genRecipes()
    newUser["notes"] = genNotes()
    newUser["stats"] = genStats()
    return newUser
  end

  def genRecipes()
    rtn = []
    self.recipes.each do |recipe|
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

  def genFoods()
    rtn = []
    ids = []

    self.user_foods.each_with_index do |item, i|
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
            # dopObj["expired"] = DateTime.now > item["expiration_date"].to_datetime
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
        foodObj["image"] = food["image"]
        foodObj["category"] = food["category"]
        # foodObj["combined_amount"] = "UPDATE ME"
        dopObj["user_food_id"] = item.id
        dopObj["amount"] = item["amount"]
        # dopObj["expired"] = DateTime.now > item["expiration_date"].to_datetime
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


  def checkExpire
    foodsToCheck = self.user_foods.where(expired: false)
    for i in foodsToCheck
      puts "FOOOOOD"
      puts i.expiration_date
      if(DateTime.now.day > i.expiration_date.to_datetime.day)
        i.update(expired: true)
      end
      puts "FOOOOOD"
    end
  end


  def genNotes()

    #refactor dont need all info
    rtnObj = {}
    rtnObj["within_current_month"] = []
    rtnObj["within_week"] =  []
    rtnObj["tomorrow"] = []
    rtnObj["today"] = []
    self.user_foods.each do |food|
      if(food.expired == false)
        obj = {}
        obj["specifc_data"] = food
        obj["food_data"] = Food.find(food.food_id)
        todayDate = DateTime.now
        foodDate = food.expiration_date.to_datetime
        puts food
        puts food.expiration_date
        puts todayDate
        puts foodDate.day
        puts todayDate.day
        month = (foodDate.month == todayDate.month) && (foodDate.year == todayDate.year)
        week = (foodDate.day - todayDate.day).abs <= 7 && (foodDate.year == todayDate.year) && (foodDate.month == todayDate.month)
        day = (foodDate.day - todayDate.day).abs == 1 && (foodDate.year == todayDate.year) && (foodDate.month == todayDate.month) && (foodDate.cweek == todayDate.cweek)
        today = (foodDate.day == todayDate.day) && (foodDate.year == todayDate.year) && (foodDate.month == todayDate.month) && (foodDate.cweek == todayDate.cweek)
        if today
          puts "expires today"
          rtnObj["today"].push(obj)
        elsif day
          puts "expires tomorrow"
          rtnObj["tomorrow"].push(obj)
        elsif week
          puts "expires within a week"
          rtnObj["within_week"].push(obj)
        elsif month
          puts "expires within this month"
          rtnObj["within_current_month"].push(obj)
        end
      end
    end
    return rtnObj
  end

  def genStats
    return "hi"
  end


end
