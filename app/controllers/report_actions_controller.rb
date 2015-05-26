class ReportActionsController < ApplicationController

    before_action :doorkeeper_authorize!
    
    def create
        report_action_type_name = params.require(:report_action_type_name)
        report = Report.find(params.require(:report_id))
        organization_id = report.workspace.organization
        report_action_type = ReportActionType.find_by_organization_id_and_name(
            organization_id, report_action_type_name)
        if report_action_type.nil?
            render nothing: true, status: :not_found
        else
            @report_action = ReportAction.new(report_action_params)
            @report_action.user = current_user
            @report_action.report_action_type = report_action_type

            if @report_action.save
                render json: @report_action, status: :created
            else
                render json: @report_action, status: :unprocessable_entity
            end
        end
    end

    def index
        report_id = params.require(:report_id)
        report = Report.find(report_id)
        render json: report.report_actions, status: :ok
    end

    private
    def report_action_params
        params.require(:report_action).permit(:report_id, :report_state_id).tap do |whitelisted|
            whitelisted[:data] = params[:data]
        end
    end

end
