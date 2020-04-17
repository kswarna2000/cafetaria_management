class MenusController < ApplicationController
  def index
    render "index"
  end

  def new
    render "new"
  end

  def create
    name = params[:name]
    new_menu = Menu.create!(
      name: name,
    )
    session[:current_menu_id] = new_menu.id
    redirect_to new_menuitem_path
  end

  def edit
    id = params[:id]
    session[:current_menu_id] = id
    redirect_to new_menuitem_path
  end
end
