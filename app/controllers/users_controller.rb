class UsersController < ApplicationController

  def show
    token = request.headers["Authentication"].split(' ')[1]
    payload = decode(token)
    @user = User.find(payload["user_id"])
    if @user
      @user.checkExpire()
      render json: @user.genUser()
    end
  end

  def create
    @newUser = User.create(username: params["username"],
                          password: params["password"],
                          first_name: params["firstname"],
                          last_name: params["lastname"],
                          email: params["email"],
                          profile_image: params["image"])
    render json: @newUser.genUser()
  end

end
