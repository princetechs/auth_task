class SessionsController < ApplicationController
  def show
    check_session
  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      if user.two_factor_enabled?
        user.generate_two_factor_token
        user.send_two_factor_authentication_email
        session[:user_mail]=params[:email]
        redirect_to verify_path
      else
        log_in user
        redirect_to root_path
      end
    else
      flash.now[:error] = "Incorrect email or password"
      render 'show'
    end
  end

  def verify_index
    if !session[:user_mail]
     redirect_to not_authorized_path
    end
  end

  def verify_2fa
    if session[:user_mail]
        user=User.find_by_email(session[:user_mail]) 
        if user.two_factor_token==params["token"]
          session[:user_id]=user.id
          session[:two_fa_login] = true
          print("inside 2fa")
          redirect_to dashboard_path
        else
          print("invalid token")
          
        end
      else
        redirect_to not_authorized_path
  end
end
 

  def destroy
    log_out if session[:user_id]
    print("check session")
    print(session["user_id"])
    redirect_to root_path
  end
end
