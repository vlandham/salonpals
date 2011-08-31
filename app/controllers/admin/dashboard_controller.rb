module Admin
  class DashboardController < BaseController
    before_filter :authenticate_user!
  
    def index
      respond_to do |format|
        format.html # index.html.erb
        #format.mobile
      end
    end
  
  end
end