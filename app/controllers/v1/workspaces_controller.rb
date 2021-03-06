class V1::WorkspacesController < ApplicationController

	before_action :doorkeeper_authorize!

	
	def show
		@workspace = Workspace.find(params[:id])
		render json: @workspace
	end

	
	def index
		organization_id = params.require(:organization_id)
		organization = Organization.find(organization_id)
		workspaces = organization.workspaces
		render json: workspaces, status: :ok
	end

	
	def admins
		workspace = Workspace.find(params.require(:workspace_id))
		user_id = params.require(:user_id)
		user = User.find(user_id)
		role = user.add_role :admin, workspace
		render json: role, status: :ok
	end
	
	
	def dashboard
		workspace = Workspace.find(params[:workspace_id])
		@dashboard = workspace.dashboard start_date: params[:start_date],
			end_date: params[:end_date]
		render json: @dashboard, status: :ok
	end

	def excel
		render json: {
			start_date: params.require(:start_date),
			end_date: params.require(:end_date)
		}, status: :ok
	end

	def delete_user
		user = User.find(params.require(:id))
		invitation = user.workspace_invitations.find_by_workspace_id(params.require(:workspace_id))
		if invitation.present?
			invitation.destroy
			user.remove_role :user, invitation.workspace
			user.remove_role :admin, invitation.workspace
			render nothing: true, status: :no_content
		else
			render json: {
				error: "El usuario no pertenece al workspace seleccionado"
			}, status: :not_found
		end
	end

end
