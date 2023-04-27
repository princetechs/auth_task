module SessionsHelper
    def log_in(user)
        session[:user_id] = user.id
    end
    def log_out
      session.delete(:user_id)   
   end
   
   def check_session
    if session[:user_id]
      redirect_to dashboard_path
    else
      redirect_to not_authorized_path
    end
   end
end