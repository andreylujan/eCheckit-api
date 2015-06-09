class OrganizationsController < ApplicationController

	before_action :doorkeeper_authorize!
	
	def show
		@organization = Organization.find(params[:id])
		render json: @organization
	end
end
