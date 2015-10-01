class RegionsController < ApplicationController
    before_action :doorkeeper_authorize!

    api!
    def index
        @regions = Region.all
        render json: @regions, status: :ok
    end
end
