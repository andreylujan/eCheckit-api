class ReportActionsController < ApplicationController

    before_action :doorkeeper_authorize!
    
    def create
        @report_action = ReportAction.new(report_action_params)
        if @report_action.save
        else
        end
    end

    def index
    end

    private
    def report_action_params
        params.require(:report_action).permit(:report_action_type_id, 
            :report_id).tap do |whitelisted|
            whitelisted[:data] = params[:data]
        end
    end

end
