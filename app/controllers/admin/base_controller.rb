module Admin
  class BaseController < ApplicationController
    before_filter :authenticate_user!    
    before_filter :verify_admin

    private
    def verify_admin
      redirect_to root_url unless current_user and current_user.admin?
    end
  end
end