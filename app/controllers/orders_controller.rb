class OrdersController < ApplicationController
  before_filter :authenticate_user!
  
  def new
    @user = current_user
    @post = @user.posts.find(params[:post_id])
    @order = Order.new_from_post_user @post, @user
  end
  
  def edit
    @user = current_user
    @post = @user.posts.find(params[:post_id])
    @order = @post.order
  end
  
  
  def create
    @user = current_user
    @post = current_user.posts.find(params[:post_id])
    @order = @post.build_order(params[:order])
    @order.ip_address = request.remote_ip
    respond_to do |format|
      if @order.save
        if @order.purchase
          format.html { redirect_to(@post, :notice => 'Post was successfully updated.') }
          format.xml  { render :xml => @post, :status => :created, :location => @post }
        else
          format.html { render :action => "new", :post_id => @post.id }
          format.xml  { render :xml => @post.errors, :status => :unprocessable_entity }
        end
      else
        render :action => 'new'
      end
    end
  end
  
  def update
    @user = current_user
    @post = @user.posts.find(params[:post_id])
    @order = @post.order

    respond_to do |format|
      if @order.update_attributes(params[:order])
        if @order.purchase
          format.html { redirect_to(@post, :notice => 'Post was successfully updated.') }
          format.xml  { head :ok }
        else
          format.html { render :action => "new", :post_id => @post.id }
          format.xml  { render :xml => @post.errors, :status => :unprocessable_entity }
        end
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @post.errors, :status => :unprocessable_entity }
      end
    end
  end
end
