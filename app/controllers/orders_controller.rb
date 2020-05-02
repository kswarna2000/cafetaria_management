class OrdersController < ApplicationController
  def index
    render "index"
  end

  def create
    order_date = DateTime.now
    user_id = current_user.id
    delivered_at = nil
    new_order = Order.create!(
      order_date: order_date,
      user_id: current_user.id,
      delivered_at: delivered_at,
      total: 0,
      status: "inprogress",
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
    order.status = "completed"
    order.save!
    redirect_to "/orders"
  end

  def new
    render "new"
  end

  def complain
    id = params[:id]
    order = Order.where(user_id: current_user.id).find(id)
    order.delivered_at = nil
    order.status = "complaint"
    order.save!
    redirect_to "/orders"
  end

  def complaints
    render "complaints"
  end

  def viewcomplaints
    render "view_complaints"
  end

  def showorders
    render "showorders"
  end

  def report
    render "report"
  end

  def store
    current_order = Order.where(user_id: current_user.id).find(session[:current_order_id])
    current_order.total = params[:total]
    current_order.save!
    session[:current_order_id] = nil
    redirect_to orders_path
  end
end
