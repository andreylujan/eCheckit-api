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

  
  def change_password
    @user = User.find_by_email(params.require(:email).downcase)
    password = params.require(:password)
    password_confirmation = params.require(:password_confirmation)
    reset_password_token = params.require(:reset_password_token)

    # First check if email is valid
    if @user.present?
      # Now see if reset token is valid and hasn't expired
      if @user.valid_reset_token?(reset_password_token)
        @user.password = password
        @user.password_confirmation = password_confirmation
        # Change password
        if @user.save
          @user.clear_reset_token
          render json: @user, status: :ok
        else
          render json: {
            errors: @user.errors.full_messages
            }, status: :unprocessable_entity
        end
      else
        render nothing: true, status: :unauthorized
      end
    else
      render nothing: true, status: :not_found
    end
  end

  
  def show
    @user = User.find(params[:id])
    render json: @user
  end

  def request_validation_token
    email = params.require(:email).downcase
    user = User.find_by_email(email)
    # Check if user exists
    if user.present?
      user.generate_reset_token
      user.send_password_confirmation_token
      render json: {
        reset_password_token: user.reset_password_token,
        reset_password_sent_at: user.reset_password_sent_at
      }, status: :ok
    else
      render nothing: true, status: :not_found
    end
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
