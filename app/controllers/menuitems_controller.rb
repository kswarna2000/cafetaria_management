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

  def edit
    @update_menuitem = Menuitem.find(params[:id])
    render "edititem"
  end

  def destroy
    id = params[:id]
    menuitem = Menuitem.find(id)
    menuitem.destroy
    redirect_to new_menuitem_path
  end

  def update
    id = params[:id]
    menuitem = Menuitem.find(id)
    menuitem.item_name = params[:item_name]
    menuitem.item_description = params[:item_description]
    menuitem.item_price = params[:item_price]
    menuitem.save
    redirect_to new_menuitem_path
  end
end
