class ReportActionsController < ApplicationController

    before_action :doorkeeper_authorize!
    
    def create
        @report_action = ReportAction.new(report_action_params)
        @report_action.user = current_user
        if @report_action.save
            render json: @report_action, status: :created
        else
            render json: @report_action, status: :unprocessable_entity
        end
    end

    def index
        report_id = params.require(:report_id)
        report = Report.find(report_id)
        render json: report.report_actions, status: :ok
    end

    private
    def report_action_params
        params.require(:report_action).permit(:report_action_type_id, 
            :report_id).tap do |whitelisted|
            whitelisted[:data] = params[:data]
        end
    end

end
