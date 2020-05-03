class OrdersController < ApplicationController
  @@orders_report = nil

  def index
    render "index"
  end

  def create
    order_date = DateTime.now
    user_id = current_user.id
    delivered_at = nil
    if @current_user.role == "customer"
      new_order = Order.create!(
        order_date: order_date,
        user_id: current_user.id,
        delivered_at: delivered_at,
        total: 0,
        status: "inprogress",
        walkin_customer: false,
      )
    else
      new_order = Order.create!(
        order_date: order_date,
        user_id: current_user.id,
        delivered_at: delivered_at,
        total: 0,
        status: "inprogress",
        walkin_customer: true,
      )
    end
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
    @orders_report = Order.where(status: "completed").order(:order_date)
    render "report"
  end

  def filter
    if params[:from_date] == "" or params[:to_date] == ""
      flash[:error] = "from date cannot be blank"
      redirect_to "/orders/showreport"
      return
    end
    from_date = Date.parse params[:from_date]
    to_date = Date.parse params[:to_date]
    if from_date > to_date
      flash[:error] = "From date cannot be greater than to date"
      redirect_to "/orders/showreport"
      return
    end
    @@orders_report = Order.where(status: "completed").where("order_date BETWEEN ? and ?", from_date.to_datetime, to_date.to_datetime)
    if @@orders_report.empty?
      flash[:error] = "No records found"
    end
    redirect_to "/orders/showreport"
  end

  def customer
    session[:show_customer_id] = params[:user_id]
    @@orders_report = Order.where(user_id: params[:user_id])
    redirect_to "/orders/showreport1"
  end

  def walkincustomer
    @@orders_report = Order.where(walkin_customer: true)
    redirect_to "/orders/showreport1"
  end

  def filter1
    if params[:from_date] == "" or params[:to_date] == ""
      flash[:error] = "from date cannot be blank"
      redirect_to "/orders/showreport1"
      return
    end
    from_date = Date.parse params[:from_date]
    to_date = Date.parse params[:to_date]
    if from_date > to_date
      flash[:error] = "From date cannot be greater than to date"
      redirect_to "/orders/showreport1"
      return
    end
    @@orders_report = Order.where(status: "completed", user_id: session[:show_customer_id]).where("order_date BETWEEN ? and ?", from_date.to_datetime, to_date.to_datetime)
    if @@orders_report.empty?
      flash[:error] = "No records found"
    end
    redirect_to "/orders/showreport1"
  end

  def showreport1
    @orders_report = @@orders_report
    render "report1"
  end

  def showreport
    @orders_report = @@orders_report
    render "report"
  end

  def store
    current_order = Order.where(user_id: current_user.id).find(session[:current_order_id])
    current_order.total = params[:total]
    current_order.save!
    session[:current_order_id] = nil
    redirect_to orders_path
  end

  def store1
    orderitem_list = Orderitem.where(in_cart: true)
    if orderitem_list.empty?
      flash[:error] = "Order cannot be empty"
      redirect_to "/orderitems/new1"
      return
    end
    order_date = DateTime.now
    user_id = current_user.id
    delivered_at = nil

    if @current_user.role == "customer"
      new_order = Order.create!(
        order_date: order_date,
        user_id: current_user.id,
        delivered_at: delivered_at,
        total: 0,
        status: "inprogress",
        walkin_customer: false,
      )
    else
      new_order = Order.create!(
        order_date: order_date,
        user_id: current_user.id,
        delivered_at: delivered_at,
        total: 0,
        status: "inprogress",
        walkin_customer: true,
      )
    end
    sum = 0
    orderitem_list.each do |orderitem|
      sum += orderitem.menu_item_price * orderitem.menu_item_quantity
      orderitem.in_cart = false
      orderitem.order_id = new_order.id
      orderitem.save!
    end
    new_order.total = sum
    new_order.save!
    flash[:success] = "Placed order successfully!!"
    redirect_to "/orderitems/new1"
  end
end
