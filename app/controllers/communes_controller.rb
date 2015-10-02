class CommunesController < ApplicationController
    before_action :doorkeeper_authorize!

    api!
    def index
    	region_id = params.require(:region_id)
    	region = Region.find(region_id)
    	@communes = region.communes
    	render json: @communes, status: :ok
    end
end
