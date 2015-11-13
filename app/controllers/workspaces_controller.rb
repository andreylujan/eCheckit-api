class WorkspacesController < ApplicationController

	before_action :doorkeeper_authorize!

	api!
	def show
		@workspace = Workspace.find(params[:id])
		render json: @workspace, include: [ :users ]
	end

	api!
	def index
		organization_id = params.require(:organization_id)
		organization = Organization.find(organization_id)
		workspaces = organization.workspaces
		render json: workspaces, status: :ok
	end

	api!
	def admins
		workspace = Workspace.find(params.require(:workspace_id))
		user_id = params.require(:user_id)
		user = User.find(user_id)
		role = user.add_role :admin, workspace
		render json: role, status: :ok
	end
	
	api!
	def dashboard
		workspace = Workspace.find(params[:workspace_id])
		@dashboard = workspace.dashboard start_date: params[:start_date],
			end_date: params[:end_date]
		render json: @dashboard, status: :ok
	end

	api :DELETE, '/workspaces/:workspace_id/users/:id', "Remove a user from a workspace"
	param :workspace_id, :number, required: true
	param :id, :number, required: true
	description 'Remove a user from a workspace'
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
