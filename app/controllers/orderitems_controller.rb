class OrderitemsController < ApplicationController
  def index
    render "index"
  end

  def create
    order_id = session[:current_order_id]
    menu_item_id = params[:menu_item_id]
    menu_item_name = params[:menu_item_name]
    menu_item_price = params[:menu_item_price].to_f
    menu_item_quantity = params[:menu_item_quantity].to_i
    neworderitem = Orderitem.create!(
      order_id: order_id,
      menu_item_id: menu_item_id,
      menu_item_name: menu_item_name,
      menu_item_price: menu_item_price,
      menu_item_quantity: menu_item_quantity,
    )
    redirect_to orderitems_path
  end

  def new
    render "new"
  end

  def display
    session[:show_order_id] = params[:order_id]
    redirect_to "/orderitems/showitems"
  end

  def showitems
    render "display"
  end

  def showmenuitems
    session[:show_menu_id] = params[:menu_item_id]
    redirect_to orderitems_path
  end

  def redirect
    redirect_to orders_path
  end
end
