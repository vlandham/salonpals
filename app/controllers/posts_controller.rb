class PostsController < ApplicationController
  before_filter :authenticate_user!, :only => [:new, :edit, :create, :update]
  around_filter :catch_not_found, :only => [:edit, :create, :update]

  def index
    @posts = Post.search_location(params[:location])

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @posts }
    end
  end
  
  def show
    @post = Post.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @post }
    end
  end

  # GET /posts/new
  # GET /posts/new.xml
  def new
    @user = current_user
    session[:post_params] ||= {}
    @post = @user.posts.build(session[:post_params])
    @post.current_step = session[:post_step]
  end

  
  def preview
    @user = current_user
    @post = @user.posts.find(params[:id])
  end

  # POST /posts
  # POST /posts.xml
  def create
    @user = current_user
    session[:post_params].deep_merge!(params[:post]) if params[:post]
    @post = @user.posts.build(session[:post_params])
    @post.current_step = session[:post_step]
    
    if params[:back_button]
      @post.previous_step
      @post.order = nil
    elsif @post.last_step?
      @post.save if @post.all_valid?
    else
      @post.order = nil
      if @post.valid?
        @post.next_step
      end
      @post.build_order
    end

    session[:post_step] = @post.current_step
    
    if @post.new_record?
      render 'new'
    else
      session[:post_step] = session[:post_params] = nil
      flash[:notice] = "Post saved!"
      redirect_to @post
    end
  end
  
  # GET /posts/1/edit
  def edit
    @user = current_user
    @post = @user.posts.find(params[:id])
  end
  

  # PUT /posts/1
  # PUT /posts/1.xml
  def update
    @user = current_user
    @post = @user.posts.find(params[:id])
 
      respond_to do |format|
        if @post.update_attributes(params[:post])
          format.html { redirect_to(@post, :notice => 'Post was successfully updated.') }
          format.xml  { head :ok }
        else
          format.html { render :action => "edit" }
          format.xml  { render :xml => @post.errors, :status => :unprocessable_entity }
        end
      end
  end
  
  private

  def catch_not_found
    yield
  rescue ActiveRecord::RecordNotFound
    redirect_to root_url, :flash => { :error => "You do not own this post." }
  end
  
end
