class AuthController < ApplicationController

  def genFoods(user)
    rtn = []
    user.user_foods.each_with_index do |item, i|
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

  def genRecipes(user)
    rtn = []
    byebug
    user.recipe_foods.each_with_index do |item, i|
      byebug
      recipe = Recipe.find(item["recipe_id"])
      obj = {}
      obj["title"] = recipe.title
      obj["description"] = recipe.description
      obj["instructions"] = recipe.instructions
      obj["category"] = recipe.category
      obj["food_id"]=item.food_id
      obj["name"] = Food.find(item.food_id)["name"]
      obj["amount"] = item.amount
      rtn.push(obj)
    end
    byebug
    return rtn
  end

  def create
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      payload = {user_id: @user.id}
      token = encode(payload)
      render json: {
        message: "Authenticated! You are logged in",
        authenticated: true,
        user: @user,
        foods: genFoods(@user),
        recipes: byebug,
        token: token
      }, status: :accepted
    else
      render json: {
        message: "WRONG! Are you a hacker??",
        authenticated: false
      }, status: :not_acceptable
    end
  end
end
