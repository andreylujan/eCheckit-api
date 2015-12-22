class V2::FeedbacksController < ApplicationController

  before_action :doorkeeper_authorize!
  
  
  def create
    @feedback = Feedback.new(feedback_params)
    @feedback.user = current_user
    if @feedback.save
      render json: @feedback, status: :created
    else
      render json: @feedback, status: :unprocessable_entity
    end
  end

  private
  def feedback_params
    params.require(:feedback).permit(:comment, :rating)
  end
end
