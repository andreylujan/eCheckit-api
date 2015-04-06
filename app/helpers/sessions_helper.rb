# -*- encoding : utf-8 -*-
module SessionsHelper

  def current_user
    if doorkeeper_token and doorkeeper_token.resource_owner_id
      @current_user ||= User.find(doorkeeper_token.resource_owner_id)
    end
  end

end
