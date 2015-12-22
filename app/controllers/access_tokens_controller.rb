class AccessTokensController < ApplicationController

  
  def create
    email = params.require(:email).downcase
    password = params.require(:password)
    @user = User.find_by_email(email)
    if @user.present? and @user.valid_password? password
      @user.create_token
      render json: @user, status: :ok, serializer: UserSerializer
    else
      render nothing: true, status: :unauthorized
    end
  end

end