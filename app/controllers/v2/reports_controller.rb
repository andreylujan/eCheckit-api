class V2::ReportsController < ApplicationController

  require 'amazon'


  before_action :doorkeeper_authorize!, except: :index

  
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

  def destroy
    @report = Report.find(params[:id])
    @report.destroy
    render nothing: true, status: :no_content
  end

  def create_visit
    @report = Report.new(create_visit_params)
    @report.report_state = ReportState.find_by_id(393)
    workspace = @report.workspace
    construction_id = params.require(:construction_id)
    if workspace.name == 'DOM'

      construction = Construction.find(construction_id)
      client = construction.client
      @report.title = client.name

      # Create client report field
      client_field = ReportField.new report_field_type_id: 15,
      report: @report, value: {
        client_id: client.id,
        name: client.name,
        client_rut: client.rut,
      },
      editable: false
      @report.report_fields << client_field

      # Create construction report field
      construction_field = ReportField.new report_field_type_id: 16,
      report: @report, value: {
        construction_id: construction.id,
        client_id: client.id,
        name: construction.name,
        address: construction.address
      },
      editable: false
      @report.report_fields << construction_field
    end

    @report.creator = current_user
    @report.internal_id = SecureRandom.uuid

    if @report.save
      AssignJob.perform_later @report.id
      render json: @report, status: :created
    else
      render json: @report, status: :unprocessable_entity
    end
  end

  
  def index
    workspace_id = params.require(:workspace_id)
    workspace = Workspace.find(workspace_id)
    @reports = workspace.reports
    respond_to do |format|
      format.json do
        reports_json = []
        @reports.each do |r|
          reports_json << ReportIndexSerializer.new(r).as_json
        end
        render json: reports_json, status: :ok
      end
      format.csv do
        headers['Content-Disposition'] = "attachment; filename=\"reportes.csv\""
        headers['Content-Type'] ||= 'text/csv'
      end
    end
  end

  
  def show
    @report = Report.find(params[:id])
    render json: @report, status: :ok
  end

  
  def update
    @report = Report.find(params[:id])

    if params["pictures_attributes"].present?
      params[:report]["pictures_attributes"] = params["pictures_attributes"]
      @report.pictures.destroy_all
    end
    if params["report_fields_attributes"].present?
      @report.report_fields.destroy_all
      params[:report]["report_fields_attributes"] = params["report_fields_attributes"]
    end


    @report.assign_attributes(update_params)

    @report.report_fields.each do |field|
      field_param = params[:report][:report_fields_attributes].find do |x|
        x["report_field_type_id"] == field.report_field_type_id
      end
      if field_param and field_param["value"]
        field.value = field_param["value"]
      end
    end

    report_state = @report.workspace.report_states.find_by_short_name("finished")
    if report_state
      @report.report_state = report_state
    end

    if @report.save
      generate_pdf
      render json: @report, status: :ok
    else
      render json: @report, status: :unprocessable_entity
    end
  end

  private
  def create_visit_params
    params.require(:report).permit(:workspace_id, :assigned_user_id, :visit_date)
  end
  def create_params
    params.require(:report).permit(:workspace_id, :title,
                                   :report_state_id, :assigned_user_id,
                                   :longitude, :latitude, :address, :city, :country,
                                   :region, :commune, :reference, :comment, :internal_id,
                                   :start_date, :finish_date, :finish_latitude, :finish_longitude,
                                   :visit_date, :start_latitude, :start_longitude,
                                   pictures_attributes: [ :url, :comment ],
                                   report_fields_attributes: [ :report_field_type_id, :value ])
  end

  def update_params
    params.require(:report).permit(:report_state_id,
                                   :longitude, :latitude, :address, :city, :country,
                                   :region, :commune, :reference, :comment,
                                   :start_date, :finish_date, :finish_latitude, :finish_longitude,
                                   :visit_date, :start_latitude, :start_longitude,
                                   pictures_attributes: [ :url, :comment ],
                                   report_fields_attributes: [ :report_field_type_id, :value ])
  end

end
