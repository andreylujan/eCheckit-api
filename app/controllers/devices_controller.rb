class DevicesController < ApplicationController

	before_action :doorkeeper_authorize!

	def create
		user = current_user
		@device = Device.new(device_params)
		@device.user = user
		if @device.save
			render json: @device, status: :created
		else
			device_json = DeviceSerializer.new(@device).as_json
			device_json[:errors] = @device.errors
			render json: device_json, status: :unprocessable_entity
		end
	end

	def update
		@device = Device.find(params[:id])
		if @device.update_attributes device_params
			render json: @device, status: :ok
		else
			device_json = DeviceSerializer.new(@device).as_json
			device_json[:errors] = @device.errors
			render json: device_json, status: :unprocessable_entity
		end
	end

	def destroy
		@device = Device.find(params[:id])
		@device.destroy
		render nothing: true, status: :no_content
	end

	private
	def device_params
		params.require(:device).permit(:device_token, :registration_id, :uuid, 
			:architecture, :address, :locale, :manufacturer, :model, :name, 
			:os_name, :processor_count, :version)
	end
end
