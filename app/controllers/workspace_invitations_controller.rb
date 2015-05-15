class WorkspaceInvitationsController < ApplicationController

	def create
		
		@workspace_invitation = WorkspaceInvitation.new workspace_invitations_params
		if params[:email]
			@workspace_invitation.user = User.find_by_email(params[:email])
		end

		if @workspace_invitation.save
			render json: @workspace_invitation, status: :created
		else
			render json: @workspace_invitation, status: :unprocessable_entity
		end
	end

	def update
		confirmation_token = params.require(:confirmation_token)
		@workspace_invitation = WorkspaceInvitation.find_by_confirmation_token confirmation_token
		
		if @workspace_invitation.present?
			if @workspace_invitation.update_attributes update_params
				render json:  @workspace_invitation, status: :ok
			else
				render json: @workspace_invitation, status: :unprocessable_entity
			end
		else
			render nothing: true, status: :not_found
		end
		
	end

	def show
		if params[:user_id] and params[:workspace_id]
			@workspace_invitation = WorkspaceInvitation.find_by_user_id_and_workspace_id params[:user_id], params[:workspace_id]	
		else
			@workspace_invitation = WorkspaceInvitation.find(params.require(:id))
		end

		if @workspace_invitation.present?
			render json: @workspace_invitation, status: :ok
		else
			render nothing: true, status: :not_found
		end
	end

	

	private
	def workspace_invitations_params
		params.require(:workspace_invitation).permit(:user_id, :workspace_id)
	end

	def update_params
		params.require(:workspace_invitation).permit(:accepted)
	end
end
