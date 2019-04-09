class UserRecipesController < ApplicationController
  def create
    userId = params[:userId]
    recipeId = params[:recipeId]

    user = User.find(userId)

    UserRecipe.create(user_id: userId, recipe_id: recipeId, mine: false)

    render json: user
  end

  def destroy
    userId = params[:userId]
    recipeId = params[:recipeId]

    user = User.find(userId)

    favRecipe = UserRecipe.find_by(user_id: userId, recipe_id: recipeId)
    favRecipe.destroy

    render json: user
  end
end
