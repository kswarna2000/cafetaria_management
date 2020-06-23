class MenusController < ApplicationController
  def index
    render "index"
  end

  def new
    session[:current_menu_id] = nil
    render "new"
  end

  def create
    name = params[:name]
    new_menu = Menu.new(
      name: name,
      user_id: @current_user.id,
      is_active: true,
    )
    if new_menu.save
      session[:current_menu_id] = new_menu.id
      redirect_to new_menuitem_path
    else
      flash[:error] = new_menu.errors.full_messages.join(",")
      redirect_to new_menu_path
    end
  end

  def edit
    id = params[:id]
    session[:current_menu_id] = id
    redirect_to new_menuitem_path
  end

  def destroy
    id = params[:id]
    menu = Menu.find(id)
    Menuitem.where(menu_id: id).each do |menuitem|
      menuitem.status = "delete"
      menuitem.save
    end
    menu.destroy
    redirect_to "/menus"
  end

  def status
    id = params[:id]
    menu = Menu.find(id)
    if menu.is_active == true #if menu is active then all menu items are set active
      menu.is_active = false
      Menuitem.where(menu_id: id, status: "active").each do |menuitem|
        menuitem.status = "inactive"
        menuitem.save
      end
    else
      menu.is_active = true
      Menuitem.where(menu_id: id, status: "inactive").each do |menuitem|
        menuitem.status = "active"
        menuitem.save
      end
    end
    menu.save
    redirect_to "/menus"
  end
end
