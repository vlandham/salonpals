class Users::PostsController < ApplicationController
  def index
    @user = current_user
    @active_posts = @user.posts.active
    @inactive_posts = @user.posts.inactive

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @posts }
    end
  end  
end