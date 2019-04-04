class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    render json: @user
  end

  # def update
  #   @user = User.find(params[:id])
  #   if(!params["food"].nil?)
  #     params["food"].each do |food|
  #       UserFood.create(user_id: @user.id,
  #                               food_id: food["id"],
  #                               active: true,
  #                               amount: "",
  #                               price: 5.00,
  #                               expiration_date: "04/4/2019",
  #                               expired: false)
  #     end
  #   end
  #
  #   # if(!params["userInfo"].nil?)
  #   #
  #   # end
  #   byebug
  # end

end
