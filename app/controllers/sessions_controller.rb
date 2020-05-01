class SessionsController < ApplicationController
  skip_before_action :ensure_user_logged_in

  def new
  end

  def create
    user = User.find_by(email: params[:email], role: params[:role])
    if user && user.authenticate(params[:password_digest])
      session[:current_user_id] = user.id
      redirect_to "/"
    else
      flash[:error] = "Your login attempt is invalid"
      redirect_to new_session_path
    end
  end

  def destroy
    session[:current_user_id] = nil
    @current_user = nil
    redirect_to "/"
  end
end
