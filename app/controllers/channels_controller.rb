class ChannelsController < ApplicationController

	before_action :doorkeeper_authorize!

	def create

		if params[:subchannels_attributes].present?
			params[:channel][:subchannels_attributes] = params[:subchannels_attributes]
		end
		@channel = Channel.new(channel_attributes)
		@channel.workspace = Workspace.find(params[:workspace_id])
		if @channel.save
			render json: @channel, status: :created
		else
			render json: @channel, status: :unprocessable_entity
		end
	end

	def index
		workspace = Workspace.find(params[:workspace_id])
		render json: workspace.organization.channels, status: :ok
	end

	def update
		
	end

	def destroy
		@channel = Channel.find(params[:id])
		@channel.destroy
		render nothing: true, status: :no_content
	end

	def channel_attributes
		params.require(:channel).permit(:name,
			subchannels_attributes: [ :name, :_destroy, :id ])
	end

end
