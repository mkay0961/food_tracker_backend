class UserRecipesController < ApplicationController

  def create
    token = request.headers["Authentication"].split(' ')[1]
    payload = decode(token)
    @user = User.find(payload["user_id"])
    if @user

      recipeId = params[:recipeId]

      UserRecipe.create(user_id: @user.id, recipe_id: recipeId, mine: false)

      render json: @user.genUser()
    end
  end

  def destroy
    token = request.headers["Authentication"].split(' ')[1]
    payload = decode(token)
    @user = User.find(payload["user_id"])
    if @user

      recipeId = params[:recipeId]

      favRecipe = UserRecipe.find_by(user_id: @user.id, recipe_id: recipeId)
      favRecipe.destroy

      render json: @user.genUser()
    end
  end
  
end
