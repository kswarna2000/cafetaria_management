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
    menu.destroy
    redirect_to "/menus"
  end
end
