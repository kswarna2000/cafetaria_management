class MenuitemsController < ApplicationController
  def new
    if session[:current_menu_id]
      @current_menu_id = session[:current_menu_id]
      render "new"
    else
      redirect_to new_menu_path
    end
  end

  def create
    menu_id = session[:current_menu_id]
    item_name = params[:item_name]
    item_description = params[:item_description]
    item_price = (params[:item_price]).to_f
    image_url = params[:image_url]
    new_menuitem = Menuitem.new(
      menu_id: menu_id,
      item_name: item_name,
      item_description: item_description,
      item_price: item_price,
      image_url: image_url,
      status: "active",
    )
    if image_url.ends_with?(".jpeg") or image_url.ends_with?(".png") or image_url.ends_with?(".jpg") or image_url == ""
      if new_menuitem.save
        flash[:success] = "Added Menuitem to the menu successfully!!"
        redirect_to new_menuitem_path
      else
        flash[:error] = new_menuitem.errors.full_messages.join(",")
        redirect_to new_menuitem_path
      end
    else
      flash[:error] = "Enter a URL with valid image extension (.jpeg, .jpg, .png)!! or leave the field blank"
      redirect_to new_menuitem_path
      return
    end
  end

  def edit
    @update_menuitem = Menuitem.where(menu_id: session[:current_menu_id]).find(params[:id])
    render "edititem"
  end

  def destroy
    id = params[:id]
    menuitem = Menuitem.where(menu_id: session[:current_menu_id]).find(id)
    menuitem.status = "delete"
    menuitem.save

    redirect_to new_menuitem_path
  end

  def update
    id = params[:id]
    menuitem = Menuitem.where(menu_id: session[:current_menu_id]).find(id)
    menuitem.item_name = params[:item_name]
    menuitem.item_description = params[:item_description]
    menuitem.item_price = params[:item_price]
    menuitem.image_url = params[:image_url]
    image_url = params[:image_url]
    if image_url.ends_with?(".jpeg") or image_url.ends_with?(".png") or image_url.ends_with?(".jpg") or image_url.trim() == ""
      if menuitem.save
        flash[:success] = "Updated item " + menuitem.item_name.to_s + " Successfully!!"
        redirect_to new_menuitem_path
      else
        flash[:error] = new_menuitem.errors.full_messages.join(",")
        render "edititem"
      end
    else
      flash[:error] = "Enter a URL with valid image extension (.jpeg, .jpg, .png)!! or leave the field blank"
      render "edititem"
      return
    end
  end

  def done
    menu_id = params[:menu_id]
    if Menuitem.where(menu_id: menu_id).exists?
      flash[:success] = "Updated Menu Successfully!!"
      redirect_to "/menus/new"
    else
      flash[:error] = "Menu Cannot be empty!! If left empty will be deleted!!"
      redirect_to new_menuitem_path
    end
  end

  def search
    menuitem_id = params[:menuitem_id]
    session[:search_menuitem_id] = menuitem_id

    redirect_to "/orderitems/index1"
  end

  def new1
    if session[:current_menu_id]
      @current_menu_id = session[:current_menu_id]
      render "new1"
    else
      redirect_to new_menu_path
    end
  end

  def add
    menu_id = session[:current_menu_id]
    menu_item_id = params[:menu_item_id]
    menuitem = Menuitem.find(menu_item_id)
    if menuitem.status == "delete" #if menuitem is deleted then change menu id to current menu id
      menuitem.menu_id = menu_id
      menuitem.status = Menu.find(menu_id).is_active ? "active" : "inactive"
      menuitem.save
      flash[:success] = "Added Menuitem to the menu successfully!!"
      redirect_to new_menuitem_path
      return
    else
      item_name = params[:menu_item_name]
      item_description = params[:menu_item_description]
      item_price = (params[:menu_item_price]).to_f
      image_url = params[:image_url]
      new_menuitem = Menuitem.new(
        menu_id: menu_id,
        item_name: item_name,
        item_description: item_description,
        item_price: item_price,
        image_url: image_url,
        status: "active",
      )
      if image_url.ends_with?(".jpeg") or image_url.ends_with?(".png") or image_url.ends_with?(".jpg") or image_url == ""
        if new_menuitem.save
          flash[:success] = "Added Menuitem to the menu successfully!!"
          redirect_to new_menuitem_path
          return
        else
          flash[:error] = new_menuitem.errors.full_messages.join(",")
          redirect_to new_menuitem_path
          return
        end
      else
        flash[:error] = "Enter a URL with valid image extension (.jpeg, .jpg, .png)!! or leave the field blank"
        redirect_to new_menuitem_path
        return
      end
    end
  end
end
