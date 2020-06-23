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
    image_url = params[:image_url]
    neworderitem = Orderitem.new(
      order_id: order_id,
      menu_item_id: menu_item_id,
      menu_item_name: menu_item_name,
      menu_item_price: menu_item_price,
      menu_item_quantity: menu_item_quantity,
      in_cart: false,
      image_url: image_url,
    )
    if neworderitem.save
      redirect_to orderitems_path
    else
      flash[:error] = neworderitem.errors.full_messages.join(",")
      redirect_to orderitems_path
    end
  end

  def destroy
    id = params[:id]
    orderitem = Orderitem.where(user_id: @current_user.id).find(id)
    orderitem.destroy
    redirect_to "/orderitems/showcart"
  end

  def cart
    #order_id = session[:current_order_id]

    user_id = @current_user.id
    menu_item_id = params[:menu_item_id]
    menu_item_name = params[:menu_item_name]
    menu_item_price = params[:menu_item_price].to_f
    menu_item_quantity = params[:menu_item_quantity].to_i
    menu_image_url = params[:menu_image_url]

    orderitems = Orderitem.where(user_id: user_id, menu_item_id: menu_item_id, in_cart: true)
    if orderitems.count > 0 #if particular menuitem is already in the cart
      orderitems[0].menu_item_quantity = orderitems[0].menu_item_quantity + menu_item_quantity
      if orderitems[0].save
        flash[:success] = "Item Updated in cart successfully!! "
        redirect_to "/orderitems/index1"
        return
      else
        flash[:error] = neworderitem.errors.full_messages.join(",")
        redirect_to "/orderitems/index1"
        return
      end
    end
    neworderitem = Orderitem.new(
      menu_item_id: menu_item_id,
      menu_item_name: menu_item_name,
      menu_item_price: menu_item_price,
      menu_item_quantity: menu_item_quantity,
      in_cart: true,
      image_url: menu_image_url,
      user_id: user_id,
    )
    if neworderitem.save
      flash[:success] = "Item Added to cart successfully!! "
      redirect_to "/orderitems/index1"
    else
      flash[:error] = neworderitem.errors.full_messages.join(",")
      redirect_to "/orderitems/index1"
    end
  end

  def new
    render "new"
  end

  def new1
    render "new1"
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

  def showmenuitems1
    session[:show_menu_id] = params[:menu_item_id]
    redirect_to "/orderitems/index1"
  end

  def index1
    render "index1"
  end

  def redirect
    session[:current_order_id] = nil
    redirect_to orders_path
  end

  def showcart
    render "mycart"
  end

  def feedback
    render "feedback"
  end

  def updatefeedback
    Orderitem.where(order_id: session[:feedback_order_id]).each do |orderitem|
      orderitem.feedback = params[orderitem.id.to_s.to_sym]
      if orderitem.feedback == nil
        flash[:error] = "Please enter feedback for all items.... "
        redirect_to "/orderitems/feedback"
        return
      end
      orderitem.save
    end
    order = Order.find(session[:feedback_order_id])
    order.feedback = params[:feedback]
    order.save
    flash[:success] = "Thanks for the feedback!!! "
    redirect_to "/favourites/display"
  end

  def cancel
    flash[:success] = "Thanks for the purchase!!"
    redirect_to "/favourites/display"
  end

  def viewfeedback
    render "viewfeedback"
  end

  def orderwisefeedback
    render "orderwisefeedback"
  end
end
