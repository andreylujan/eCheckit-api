class ChannelsController < ApplicationController

	before_action :doorkeeper_authorize!

	def create
		
	end

	def index
		workspace = Workspace.find(params[:workspace_id])
		render json: workspace.organization.channels, status: :ok
	end

	def update
	end

	def destroy
	end

	def channel_attributes
		params.require(:channel).permit(:name,
			channels_attributes: [ :name, :_destroy, :id ])
	end

end
