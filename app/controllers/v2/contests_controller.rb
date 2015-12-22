class V2::ContestsController < ApplicationController

	before_action :doorkeeper_authorize!

	
	def create
		@contest = Contest.new(contest_params)
		@contest.workspace = Workspace.find(params[:workspace_id])
		if @contest.save
			render json: @contest, status: :created
		else
			contest_json = ContestSerializer.new(@contest).as_json
			contest_json[:errors] = @contest.errors
			render json: contest_json, status: :unprocessable_entity
		end
	end

	
	def show
		@contest = Contest.find(params[:id])
		render json: @contest, status: :ok
	end

	
	def update
		@contest = Contest.find(params[:id])
		if @contest.update_attributes contest_params
			render json: @contest, status: :ok
		else
			contest_json = ContestSerializer.new(@contest).as_json
			contest_json[:errors] = @contest.errors
			render json: contest_json, status: :unprocessable_entity
		end
	end

	
	def index
		workspace = Workspace.find(params[:workspace_id])
		render json: workspace.contests, status: :ok
	end

	
	def destroy
		@contest = Contest.find(params[:id])
		@contest.destroy
		render nothing: true, status: :no_content
	end

	private
	def contest_params
		params.require(:contest).permit(:starts_at, :ends_at,
			:prize_image, :prize_description,
			tier_steps: [])
	end
end
