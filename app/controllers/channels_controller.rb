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
		@channel = Channel.find(params[:id])

		if params[:subchannels_attributes].present?
			params[:subchannels_attributes].reject! do |a| 
					not a["_destroy"] and 
					@channel.subchannels.find_by_name(a["name"]).present?
			end
			params[:subchannels_attributes].each do |a|
				if a["_destroy"]
					subchannel = @channel.subchannels.find_by_name(a["name"])
					
					if subchannel.present?
						a["id"] = subchannel.id
					end
				end
			end
			
			params[:channel][:subchannels_attributes] = params[:subchannels_attributes]
		end

		if @channel.update_attributes channel_attributes
			render json: @channel, status: :ok
		else
			render json: @channel, status: :unprocessable_entity
		end
	end

	
	def destroy
		@channel = Channel.find(params[:id])
		@channel.destroy
		render nothing: true, status: :no_content
	end

	def channel_attributes
		params.require(:channel).permit(:name, :image,
			subchannels_attributes: [ :name, :_destroy, :id ])
	end

end
