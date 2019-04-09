class UserFoodsController < ApplicationController
  def addAmount(amount1, amount2)
    newAmount1 = amount1.split(" ")
    newAmount2 = amount1.split(" ")
    return "#{newAmount1[0].to_i + newAmount2[0].to_i} #{newAmount1[1]}"
  end

  def create
      @user = User.find(params[:id])
      if(!params["food"].nil?)
        params["food"].each do |food|
        food1 = UserFood.find_by(user_id: @user.id,food_id: food["id"])
        if(food1.nil?)
          UserFood.create(user_id: @user.id,
                                  food_id: food["id"],
                                  active: food["active"],
                                  amount: food["amount"],
                                  price: food["price"],
                                  expiration_date: food["expiration_date"],
                                  expired: food["expired"])
        else
          newAmount = addAmount(food1.amount,food["amount"] )
          food1.update(amount: newAmount)
        end
        end
      end
      render json: @user
  end
end
