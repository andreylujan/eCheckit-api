class ZoneAssignmentsController < ApplicationController

	before_action :doorkeeper_authorize!

	api :GET, "/workspace/:workspace_id/zone_assignments", "Show zone assignments"
	param :workspace_id, Integer, desc: "Workspace id", required: true
	def index
		workspace = Workspace.find(params[:workspace_id])
		@zone_assignments = workspace.zone_assignments
		render json: @zone_assignments
	end

	def create
		if params[:zone_managers_attributes].present?
			params[:zone_assignment][:zone_managers_attributes] = params[:zone_managers_attributes]
		end
		@zone_assignment = ZoneAssignment.new(create_params)
		@zone_assignment.workspace_id = params[:workspace_id]
		
		
		if @zone_assignment.save
			render json: @zone_assignment, status: :created
		else
			render json: @zone_assignment, status: :unprocessable_entity
		end
	end

	def update

		@zone_assignment = ZoneAssignment.find(params[:id])

		if params[:zone_managers_attributes].present?
			params[:zone_managers_attributes].reject! do |a| 
					not a["_destroy"] and
				@zone_assignment.zone_managers.find_by_user_id(a["user_id"]).present?
			end
			params[:zone_managers_attributes].each do |a|
				if a["_destroy"]
					manager = @zone_assignment.zone_managers.find_by_user_id(a["user_id"])
					
					if manager.present?
						a["id"] = manager.id
					end
				end
			end
			
			params[:zone_assignment][:zone_managers_attributes] = params[:zone_managers_attributes]
		end

		if @zone_assignment.update_attributes create_params
			render json: @zone_assignment, status: :ok
		else
			render json: @zone_assignment, status: :unprocessable_entity
		end

	end

	def destroy
		@zone_assignment = ZoneAssignment.find(params[:id])
		@zone_assignment.destroy
		render nothing: true, status: :no_content
	end

	def create_params
		params.require(:zone_assignment).permit(:channel_id, 
			:subchannel_id, :region_id, :commune_id, :workspace_id, 
			zone_managers_attributes: [ :user_id, :_destroy, :id ])
	end
end
