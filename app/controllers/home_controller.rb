class HomeController < ApplicationController
  skip_before_action :ensure_user_logged_in

  def index
    if current_user
      if current_user.role == "customer"
        redirect_to orders_path
      elsif current_user.role == "owner"
        redirect_to menus_path
      else
        redirect_to "/orders/showorders"
      end
    else
      render :index
    end
  end
end
