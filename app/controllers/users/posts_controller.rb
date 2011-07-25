class Users::PostsController < ApplicationController
  def index
    @user = current_user
    @posts = @user.posts

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @posts }
    end
  end  
end