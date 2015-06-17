class ReportsController < ApplicationController

  require 'amazon'


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
      if params[:report][:report_fields_attributes][idx]["value"]
        field.value = params[:report][:report_fields_attributes][idx]["value"]
      end
    end

    @report.creator = current_user
    if @report.save
      generate_pdf
      render json: @report, status: :created
    else
      render json: @report, status: :unprocessable_entity
    end
  end

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

  def show
    @report = Report.find(params[:id])
    render json: @report, status: :ok
  end

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
      :region, :commune, :reference, :comment,
      pictures_attributes: [ :url, :comment ],
      report_fields_attributes: [ :report_field_type_id, :value ])
  end

  def update_params
    params.require(:report).permit(:assigned_user_id, :comment, :report_state_id)
  end

  def generate_pdf

    pdf = WickedPdf.new.pdf_from_string(
      render_to_string('templates/report.html.erb')
      )
    url = Amazon.upload_pdf(pdf)
    if not url.nil?
      @report.update_attribute :pdf, url
    end
  end
end
