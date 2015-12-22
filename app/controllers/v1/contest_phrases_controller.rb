class V1::ContestPhrasesController < ApplicationController

	before_action :doorkeeper_authorize!

	
	def create
		@contest_phrase = ContestPhrase.new(contest_phrase_params)
		@contest_phrase.organization = organization
		if @contest_phrase.save
			render json: @contest_phrase, status: :created
		else
			render json: @contest_phrase, status: :unprocessable_entity
		end
	end

	
	def index
		render json: organization.contest_phrases
	end

	
	def update
		@contest_phrase = ContestPhrase.find(params[:id])
		if @contest_phrase.update_attributes(contest_phrase_params)
			render json: @contest_phrase, status: :ok
		else
			render json: @contest_phrase, status: :unprocessable_entity
		end
	end

	
	def show
		@contest_phrase = ContestPhrase.find(params[:id])
		render json: @contest_phrase
	end

	
	def destroy
		@contest_phrase = ContestPhrase.find(params[:id])
		@contest_phrase.destroy
		render nothing: true, status: :no_content
	end

	private
	def contest_phrase_params
		params.require(:contest_phrase).permit(:tier, :phrase)
	end

	def organization
		Organization.find(params[:organization_id])
	end

end
