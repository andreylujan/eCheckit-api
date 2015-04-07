class UsersController < ApplicationController

  before_action :doorkeeper_authorize!, only: [ :update, :show ]
  
  authorize_resource only: [ :update, :show ]
  
  def create
    @user = User.new(user_params)
    if @user.save
      render json: @user, status: :created
    else
      render json: @user, status: :unprocessable_entity
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      render json: @user
    else
      render json: @user, status: :unprocessable_entity
    end
  end

  def show
    @user = User.find(params[:id])
    render json: @user
  end

  private
  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :rut, :picture).tap do | whitelisted |
      whitelisted[:password] = params.require(:password)
      whitelisted[:password_confirmation] = params.require(:password_confirmation)
    end
  end

end
