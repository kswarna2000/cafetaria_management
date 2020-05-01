class OrdersController < ApplicationController
  def index
    render "index"
  end

  def create
    order_date = DateTime.now
    user_id = 1
    delivered_at = nil
    new_order = Order.create!(
      order_date: order_date,
      user_id: @current_user.id,
      delivered_at: delivered_at,
    )
    session[:current_order_id] = new_order.id
    redirect_to new_orderitem_path
  end

  def mark
    id = params[:id]
    order = Order.find(id)
    order.delivered_at = DateTime.now
    order.save!
    redirect_to orders_showorders_path
  end

  def destroy
    id = params[:id]
    order = Order.where(user_id: current_user.id).find(id)
    order.destroy
    redirect_to "/orders"
  end

  def new
    render "new"
  end

  def complain
    id = params[:id]
    order = Order.where(user_id: current_user.id).find(id)
    order.delivered_at = nil
    order.save!
    redirect_to "/orders"
  end

  def showorders
    render "showorders"
  end
end
