class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :set_locale
  before_filter :prepare_for_mobile
  
  def default_url_options(options={})
    #logger.debug "default_url_options is passed options: #{options.inspect}\n"
    { :locale => I18n.locale }
  end
  
  
  private
  
  def mobile_device?
    if session[:mobile_param]
      session[:mobile_param] == "1"
    else
      request.user_agent =~ /Mobile|webOS/
    end
  end
  helper_method :mobile_device?
  
  def prepare_for_mobile
    session[:mobile_param] = params[:mobile] if params[:mobile]
    request.format = :mobile if mobile_device?
  end
  
  def set_locale
    if current_user and !current_user.language?
      params[:locale] = current_user.language
    end
    I18n.locale = params[:locale] || I18n.default_locale
  end
  
  def catch_not_found
    yield
  rescue ActiveRecord::RecordNotFound
    redirect_to root_url, :flash => { :error => "You cannot view this page." }
  end

end
