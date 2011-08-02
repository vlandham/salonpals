class LocalesController < ApplicationController
  def show
    new_locale = valid_locale?(params[:id]) ? params[:id] : LANGUAGES.first.first
    if user_signed_in?
      @user = current_user
      @user.language = new_locale
      @user.save!
    end
    
    redirect_to posts_path(params[:locale] = new_locale)
      
  end
  
  private
  
  def valid_locale? locale
    LANGUAGES.keys.include? locale
  end
  
  
end