class AuthController < ApplicationController
  def create
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      #username is found AND password matches
      payload = {user_id: @user.id}
      token = encode(payload)
      render json: {
        message: "Authenticated! You are logged in",
        authenticated: true,
        user: @user,
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
