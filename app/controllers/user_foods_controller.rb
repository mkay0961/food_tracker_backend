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
          # foodItem = UserFood.find_by(user_id: @user.id,food_id: food["id"])
          # if(foodItem.nil?)

            UserFood.create(user_id: @user.id,
                                    food_id: food["id"],
                                    active: food["active"],
                                    amount: food["amount"],
                                    price: food["price"],
                                    expiration_date: food["expire_date"],
                                    expired: false)
          # else
          #   newAmount = addAmount(foodItem.amount,food["amount"] )
          #   foodItem.update(amount: newAmount)
          # end
        end
      end
      render json: @user.genUser()
    end
  end

  def eat
    token = request.headers["Authentication"].split(' ')[1]
    payload = decode(token)
    @user = User.find(payload["user_id"])
    puts @user
    if (!@user.nil?)
      foods = params["food"]
      if(!foods.nil?)
        foods.each do |food|

          eatenAmount = food["to_be_eaten"].split(" ")[0].to_i
          food["specific_instances"].each do |item|
            unit = food["unit"]
            puts item
            puts "TEXT"
            if(eatenAmount != 0)
              thisAmount = item["amount"].split(" ")[0].to_i
              id = item["user_food_id"]
              if(eatenAmount - thisAmount >= 0)
                puts "destory"

                eatenAmount = eatenAmount - thisAmount
                UserFood.find(id).destroy
              elsif (eatenAmount - thisAmount < 0)
                puts "update"

                remainingAmount = thisAmount - eatenAmount
                eatenAmount = 0
                UserFood.find(id).update(amount: (remainingAmount.to_s + " " + unit))
              end



            end
          end
        end

      end
      render json: @user.genUser()
    end

    end

  end
