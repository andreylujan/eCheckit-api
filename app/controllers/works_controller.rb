class WorksController < ApplicationController
	def index
		render json: {name:"obras"}
	end
end
