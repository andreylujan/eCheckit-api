class V2::ClientsController < ApplicationController

  before_action :doorkeeper_authorize!
  def index
    @clients = Client.where(workspace_id: params.require(:workspace_id))
    render json: @clients
  end

end