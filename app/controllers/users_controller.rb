class UsersController < ApplicationController
  skip_before_action :ensure_user_logged_in
  @@role = ""

  def index
    render "index"
  end

  def new
    # render "users/new"
  end

  def create
    user = User.new_user(params)
    if user.save
      if session[:current_user_id] == nil
        session[:current_user_id] = user.id
        flash[:success] = "Signed up sucessfully! You are logged in automatically"
        redirect_to ""
      else
        flash[:success] = "Added Clerk successfully"
        redirect_to ""
      end
    else
      flash[:error] = user.errors.full_messages.join(", ")
      redirect_to new_user_path
    end
  end

  def report
    render "report"
  end

  def display
    @@role = params[:role]
    puts @@role
    session[:show_user_id] = params[:id]
    redirect_to "/users/displaycustomers"
  end

  def clerks
    render "clerks"
  end

  def displaycustomers
    @role = @@role
    render "display"
  end

  def newclerk
    render "newclerk"
  end

  def check
    render plain: User.check(params)
  end
end
