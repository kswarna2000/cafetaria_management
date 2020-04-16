class MenuitemsController < ApplicationController
  def new
    @current_menu_id = session[:current_menu_id]
    render "new"
  end

  def create
    menu_id = session[:current_menu_id]
    item_name = params[:item_name]
    item_description = params[:item_description]
    item_price = (params[:item_price]).to_f
    new_menuitem = Menuitem.create!(
      menu_id: menu_id,
      item_name: item_name,
      item_description: item_description,
      item_price: item_price,
    )
    redirect_to new_menuitem_path
  end
end
