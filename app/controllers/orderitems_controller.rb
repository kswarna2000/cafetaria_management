class OrderitemsController < ApplicationController
  def index
    if session[:current_order_id]
      render "index"
    else
      redirect_to orders_path
    end
  end

  def create
    order_id = session[:current_order_id]
    menu_item_id = params[:menu_item_id]
    menu_item_name = params[:menu_item_name]
    menu_item_price = params[:menu_item_price].to_f
    menu_item_quantity = params[:menu_item_quantity].to_i
    neworderitem = Orderitem.new(
      order_id: order_id,
      menu_item_id: menu_item_id,
      menu_item_name: menu_item_name,
      menu_item_price: menu_item_price,
      menu_item_quantity: menu_item_quantity,
    )
    if neworderitem.save
      redirect_to orderitems_path
    else
      flash[:error] = neworderitem.errors.full_messages.join(",")
      redirect_to orderitems_path
    end
  end

  def new
    render "new"
  end

  def display
    session[:show_order_id] = params[:order_id]
    redirect_to "/orderitems/showitems"
  end

  def invoice
    session[:show_order_id] = params[:order_id]
    redirect_to "/orderitems/showinvoice"
  end

  def showinvoice
    render "invoice"
  end

  def showitems
    render "display"
  end

  def showmenuitems
    session[:show_menu_id] = params[:menu_item_id]
    redirect_to orderitems_path
  end

  def redirect
    session[:current_order_id] = nil
    redirect_to orders_path
  end
end
