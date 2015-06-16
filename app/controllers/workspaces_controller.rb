class WorkspacesController < ApplicationController

	# before_action :doorkeeper_authorize!

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
		@dashboard = workspace.dashboard
		render json: @dashboard, status: :ok
	end

end
