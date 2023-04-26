class SessionsController < ApplicationController
  def show
    check_session
  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id]=user.id
      if user.two_factor_enabled?
        user.generate_two_factor_token
        user.send_two_factor_authentication_email
        redirect_to verify_path
      else
        log_in user
        redirect_to root_path
      end
    else
      render 'new'
    end
  end

  def verify_index
    check_session
  end

  def verify_2fa
    user=User.find(session[:user_id])
    if user.two_factor_token==params["token"]
      session[:two_fa_login] = true
      print("inside 2fa")
      redirect_to dashboard_path
    else
      print("invalid token")
    end

  end
 

  def destroy
    log_out if session[:user_id]
    redirect_to root_path
  end
end
