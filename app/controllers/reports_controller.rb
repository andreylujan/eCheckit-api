class ReportsController < ApplicationController

  require 'amazon'


  before_action :doorkeeper_authorize!

  api!
  def create

    if params[:internal_id].present?
      @report = Report.find_by_internal_id(params[:internal_id])
      if @report.present?
        render json: @report, status: :ok
        return
      end
    end

    if params[:pictures_attributes].present?
      params[:report][:pictures_attributes] = params[:pictures_attributes]
    end
    if params[:report_fields_attributes].present?
      params[:report][:report_fields_attributes] = params[:report_fields_attributes]
    end
    
    @report = Report.new(create_params)
    @report.report_fields.each_with_index do |field, idx|
      if params[:report][:report_fields_attributes][idx]["value"]
        field.value = params[:report][:report_fields_attributes][idx]["value"]
      end
    end

    @report.creator = current_user
    if @report.save
      generate_pdf
      first_action = @report.report_actions.first
      # if first_action
      #  first_action.send_create_email
      # end
      render json: @report, status: :created
    else
      render json: @report, status: :unprocessable_entity
    end
  end

  api!
  def index
    workspace_id = params.require(:workspace_id)
    workspace = Workspace.find(workspace_id)
    reports = workspace.reports
    reports_json = []
    reports.each do |r|
      reports_json << ReportIndexSerializer.new(r).as_json
    end
    render json: reports_json, status: :ok
  end

  api!
  def show
    @report = Report.find(params[:id])
    render json: @report, status: :ok
  end

  api!
  def update
    @report = Report.find(params[:id])
    if @report.update_attributes(update_params)
      render json: @report, status: :ok
    else
      render json: @report, status: :unprocessable_entity
    end
  end

  private
  def create_params
    params.require(:report).permit(:workspace_id, :venue_id, :title, 
      :report_state_id, :assigned_user_id,
      :longitude, :latitude, :address, :city, :country,
      :region, :commune, :reference, :comment, :internal_id,
      pictures_attributes: [ :url, :comment ],
      report_fields_attributes: [ :report_field_type_id, :value ])
  end

  def update_params
    params.require(:report).permit(:assigned_user_id, :comment, :report_state_id)
  end

end
