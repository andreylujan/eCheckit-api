class WorkspacesController < ApplicationController

	before_action :doorkeeper_authorize!
	authorize_resource

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

end
