class ZoneAssignmentsController < ApplicationController

	before_action :doorkeeper_authorize!

	def index
		workspace = Workspace.find(params[:workspace_id])
		@zone_assignments = workspace.zone_assignments
		render json: @zone_assignments
	end
end
