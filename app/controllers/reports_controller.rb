class ReportsController < ApplicationController

  def create
    @report = Report.new(create_params)
    @report.creator = current_user
    if @report.save
      render json: @report, status: :created
    else
      render json: @report, status: :unprocessable_entity
    end
  end

  private
  def create_params
    params.require(:report).permit(:workspace_id, :venue_id, :title, 
      :report_state_id, :assigned_user_id,
      :longitude, :latitude, :address, :city, :country,
      :region, :commune, :reference)
  end
end
