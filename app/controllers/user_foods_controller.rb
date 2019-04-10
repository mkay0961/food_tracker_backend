class UserFoodsController < ApplicationController
  def addAmount(amount1, amount2)
    newAmount1 = amount1.split(" ")
    newAmount2 = amount1.split(" ")
    return "#{newAmount1[0].to_i + newAmount2[0].to_i} #{newAmount1[1]}"
  end

  def create
    token = request.headers["Authentication"].split(' ')[1]
    payload = decode(token)
    @user = User.find(payload["user_id"])
    if @user
      if(!params["food"].nil?)
        params["food"].each do |food|
          foodItem = UserFood.find_by(user_id: @user.id,food_id: food["id"])
          if(foodItem.nil?)
            UserFood.create(user_id: @user.id,
                                    food_id: food["id"],
                                    active: food["active"],
                                    amount: food["amount"],
                                    price: food["price"],
                                    expiration_date: food["expiration_date"],
                                    expired: food["expired"])
          else
            newAmount = addAmount(foodItem.amount,food["amount"] )
            foodItem.update(amount: newAmount)
          end
        end
      end
      render json: @user
    end
  end

  def eat
    token = request.headers["Authentication"].split(' ')[1]
    payload = decode(token)
    @user = User.find(payload["user_id"])
    if @user
      foods = params["food"]
      puts foods
      if(!foods.nil?)
        foods.each do |food|
          foodItem = UserFood.find_by(user_id: @user.id, food_id: food["food_id"])
          newAmount = foodItem.amount.to_i-food["amount"].to_i
          unit = food["amount"].split(" ")[1]
          if(!(newAmount < 0) && newAmount != 0 )
            foodItem.update(amount: "#{newAmount} #{unit}")
          elsif(newAmount == 0)
            foodItem.destroy
          end
        end
      end
      render json: @user
    end
  end
end
