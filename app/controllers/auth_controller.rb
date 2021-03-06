class AuthController < ApplicationController

  def create
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      payload = {user_id: @user.id}
      token = encode(payload)
      @user.checkExpire()
      render json: {
        message: "Authenticated! You are logged in",
        authenticated: true,
        user: @user.genUser(),
        token: token
      }, status: :accepted
    else
      render json: {
        message: "WRONG! Are you a hacker??",
        authenticated: false
      }, status: :not_acceptable
    end
  end

end
