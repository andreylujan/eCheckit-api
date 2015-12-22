class V1::ContactsController < ApplicationController

  before_action :doorkeeper_authorize!
  def index
    workspace_id = params.require(:workspace_id)
    if params[:construction_id]
      @contacts = Contact.where(construction_id: params[:construction_id])
    elsif params[:client_id]
      @contacts = Contact.joins(:construction).where(constructions: { client_id: params[:client_id]})
    else
      @contacts = Contact.joins(construction: { client: :workspace } ).where(workspaces: { id: params[:workspace_id] })
    end
    render json: @contacts
  end
end