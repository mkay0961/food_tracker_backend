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

        params["food"].each do |afood|
            UserFood.create(user_id: @user.id,
                                    food_id: afood["id"],
                                    active: true,
                                    amount: afood["amount"],
                                    price: afood["price"],
                                    expiration_date: afood["expire_date"],
                                    expired: false)

        end
      end
      render json: @user.genUser()
    end
  end

  def eat
    token = request.headers["Authentication"].split(' ')[1]
    payload = decode(token)
    @user = User.find(payload["user_id"])
    if (!@user.nil?)
      foods = params["food"]
      if(!foods.nil?)
        foods.each do |food|
          eatenAmount = food["to_be_eaten"].split(" ")[0].to_i
          food["specific_instances"].each do |item|
            unit = food["unit"]
            if(eatenAmount != 0)
              thisAmount = item["amount"].split(" ")[0].to_i
              id = item["user_food_id"]
              if(eatenAmount - thisAmount >= 0)
                eatenAmount = eatenAmount - thisAmount
                UserFood.find(id).update(active: false)
              elsif (eatenAmount - thisAmount < 0)
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


    def trash
      token = request.headers["Authentication"].split(' ')[1]
      payload = decode(token)
      @user = User.find(payload["user_id"])
      if (!@user.nil?)
        UserFood.find(params["user_food"]).update(active: false, throw_away: DateTime.now)
      end
      render json: @user.genUser()
    end

  end
