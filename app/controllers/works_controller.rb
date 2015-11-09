class WorksController < ApplicationController

	before_action :doorkeeper_authorize!
	
	def index
		render json: {name:"obras"}
	end
end
