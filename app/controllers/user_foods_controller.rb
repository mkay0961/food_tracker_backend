class UserFoodsController < ApplicationController
  def update
      @user = User.find(params[:id])
      if(!params["food"].nil?)
        params["food"].each do |food|
          UserFood.create(user_id: @user.id,
                                  food_id: food["id"],
                                  active: food["Active"],
                                  amount: food["Amount"],
                                  price: food["Price"],
                                  expiration_date: food["Expiration_date"],
                                  expired: food["Expired"])
        end
      end
      render json: @user
  end
end
