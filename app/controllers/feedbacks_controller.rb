class FeedbacksController < ApplicationController

  before_action :doorkeeper_authorize!
  
  def create
    @feedback = Feedback.new(feedback_params)
    if @feedback.save
      render json: @feedback, status: :created
    else
      render json: @feedback, status: :unprocessable_entity
    end
  end

  private
  def feedback_params
    params.require(:feedback).permit(:comment)
  end
end
