class MenuitemsController < ApplicationController
  def index
    render "index"
  end

  def create
    menu_id = (params[:menu_id]).to_i
    item_name = params[:item_name]
    item_description = params[:item_description]
    item_price = (params[:item_price]).to_f
    new_menuitem = Menuitem.create!(
      menu_id: menu_id,
      item_name: item_name,
      item_description: item_description,
      item_price: item_price,
    )
    redirect_to menuitems_path
  end
end
