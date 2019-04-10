class UsersController < ApplicationController

  def show
    token = request.headers["Authentication"].split(' ')[1]
    payload = decode(token)
    @user = User.find(payload["user_id"])
    if @user
      render json: @user.genUser()
    end
  end

end
