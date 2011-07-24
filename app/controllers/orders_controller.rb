class OrdersController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @order = @post.build_order(params[:order])
    @order.ip_address = request.remote_ip
    if @order.save
      if @order.purchase
        render :action => "success"
      else
        render :action => "failure"
      end
    else
      render :action => 'new'
    end
  end
end
