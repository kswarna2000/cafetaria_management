class OrdersController < ApplicationController
  def index
    render "index"
  end

  def create
    order_date = Date.today
    user_id = 1
    delivered_at = nil
    new_order = Order.create!(
      order_date: order_date,
      user_id: user_id,
      delivered_at: delivered_at,
    )
    redirect_to orderitems_path
  end
end
