class ReasonsController < ApplicationController

	before_action :doorkeeper_authorize!
	
	def index
		workspace = Workspace.find(params[:workspace_id])
		render json: workspace.reasons, status: :ok
	end

	def update
		@reason = Reason.find(params[:id])
		if @reason.update_attributes reason_params
			render json: @reason, status: :ok
		else
			render json: @reason, status: :unprocessable_entity
		end
	end

	def destroy
		@reason = Reason.find(params[:id])
		@reason.destroy
		render nothing: true, status: :no_content
	end

	def create
		@reason = Reason.new(reason_params)
		@reason.workspace = Workspace.find(params[:workspace_id])
		if @reason.save
			render json: @reason, status: :created
		else
			render json: @reason, status: :unprocessable_entity
		end
	end

	private
	def reason_params
		params.require(:reason).permit(:name, :image)
	end
end
