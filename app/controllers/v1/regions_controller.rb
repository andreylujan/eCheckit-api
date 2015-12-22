class V1::RegionsController < ApplicationController
    before_action :doorkeeper_authorize!

    
    def index
        @regions = Region.all
        render json: @regions, status: :ok
    end
end
