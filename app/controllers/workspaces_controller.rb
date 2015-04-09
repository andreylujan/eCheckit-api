class WorkspacesController < ApplicationController

  before_action :doorkeeper_authorize!
  authorize_resource

  def show
    @workspace = Workspace.find(params[:id])
    render json: @workspace
  end

end
