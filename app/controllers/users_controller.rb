class UsersController < ApplicationController
  def new
    if session[:user_id]
      redirect_to dashboard_path
    else
    @user = User.new
    end
  end
  def not_authorized
  end
  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to login_path
    else
      render 'new'
    end
  end

  def dashboard
    if session[:user_id]
      @user = User.find(session[:user_id])
      else
        redirect_to not_authorized_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
