class UsersController < ApplicationController

  before_action :doorkeeper_authorize!, only: [ :update, :show ]
  
  authorize_resource only: [ :update, :show ] # show
  
  def create
    @user = User.new(create_params)
    if @user.save
      render json: @user, status: :created
    else
      render json: @user, status: :unprocessable_entity
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(update_params)
      render json: @user
    else
      render json: @user, status: :unprocessable_entity
    end
  end

  def show
    @user = User.find(params[:id])
    render json: @user
  end

  def index
    if params[:confirmation_token]
      invitation = WorkspaceInvitation.find_by_confirmation_token params[:confirmation_token]
      if invitation.present?
        if @user.present?
          @user = invitation.user
          user_json = UserSerializer.new(@user).as_json
          user_json[:workspace_invitation] = WorkspaceInvitationSerializer.new(invitation).as_json
          render json: user_json, status: :ok
        else
          user_json = {
            workspace_invitation: WorkspaceInvitationSerializer.new(invitation).as_json
          }
          render json: user_json, status: :ok
        end
      else
        render nothing: true, status: :not_found
      end
    else
      organization_id = params.require(:organization_id).to_i
      @users = User.all.select do |u|
        idx = u.organizations.index { |o| o["id"] == organization_id }
        if idx != nil
          true
        else
          false
        end
      end
      render json: @users, status: :ok
    end
  end

  private
  def create_params
    params.require(:user).permit(:email, :first_name, :last_name, :picture, :is_demo).tap do | whitelisted |
      whitelisted[:password] = params.require(:password)
      whitelisted[:password_confirmation] = params.require(:password_confirmation)
    end
  end

  def update_params
    params.require(:user).permit(:picture)
  end

end
