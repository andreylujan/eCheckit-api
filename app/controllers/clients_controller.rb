class ClientsController < ApplicationController
	def index
		render json: {name:"Nicolas", lastname:"Cantó"}
	end
end
