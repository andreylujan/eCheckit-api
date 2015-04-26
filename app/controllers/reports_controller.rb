class ReportsController < ApplicationController

  before_action :doorkeeper_authorize!

  def create
    if params[:pictures_attributes].present?
      params[:report][:pictures_attributes] = params[:pictures_attributes]
    end
    if params[:report_fields_attributes].present?
      params[:report][:report_fields_attributes] = params[:report_fields_attributes]
    end
    
    @report = Report.new(create_params)
    @report.report_fields.each_with_index do |field, idx|
      field.value = params[:report][:report_fields_attributes][idx]
    end

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
      :region, :commune, :reference, :comment,
      pictures_attributes: [ :url, :comment ],
      report_fields_attributes: [ :report_field_type_id, :value ])
  end
end
