class V1::ConstructionsController < ApplicationController

  before_action :doorkeeper_authorize!
  def index
    workspace_id = params.require(:workspace_id)
    if params[:client_id]
      @constructions = Client.find(params[:client_id]).constructions
    else
      @constructions = Construction.joins(:client).where(clients: { workspace_id: params[:workspace_id ]})
    end
    render json: @constructions
  end
end
