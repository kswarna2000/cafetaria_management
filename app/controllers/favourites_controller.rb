class FavouritesController < ApplicationController
  def create
    user_id = @current_user.id
    menu_item_id = params[:menu_item_id]
    menu_item_name = params[:menu_item_name]
    menu_item_price = params[:menu_item_price].to_f
    menu_item_quantity = params[:menu_item_quantity].to_i
    image_url = params[:image_url]

    favourites = Favourite.where(user_id: user_id, menu_item_id: menu_item_id)
    if favourites.count != 0
      flash[:error] = "Item already in favourites"
      redirect_to "/favourites/display"
      return
    end
    newfavourite = Favourite.new(
      menu_item_id: menu_item_id,
      menu_item_name: menu_item_name,
      menu_item_price: menu_item_price,
      menu_item_quantity: menu_item_quantity,
      image_url: image_url,
      user_id: user_id,
    )
    if newfavourite.save
      flash[:success] = "Item Added to favourites!!"
      redirect_to "/favourites/display"
    else
      flash[:error] = neworderitem.errors.full_messages.join(",")
      redirect_to "/favourites/display"
    end
  end

  def index
    puts("hiiiii")
    puts(session[:search_favourite_menuitem_id])
    render "index"
  end

  def search
    menuitem_id = params[:menuitem_id]
    puts(params[:menuitem_id])
    session[:search_favourite_menuitem_id] = menuitem_id
    redirect_to "/favourites"
  end

  def display
    render "display"
  end

  def display1
    redirect_to "/favourites/display"
  end
end
