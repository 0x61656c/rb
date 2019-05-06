module SessionsHelper
   
   # Logs in the given user.
  def log_in(user)
    session[:user_id] = user.id
  end
   # Remembers a user in a persistent session.
  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end
   # Returns true if the given user is the current user.
  def current_user?(user)
    user == current_user
  end
   # Returns the user corresponding to the remember token cookie.

    def current_user
        @current_user ||= User.find_by(id: session[:user_id])
    end
    
    def logged_in?
        !current_user.nil?
    end
    
    def log_out
        session.delete(:user_id)
        @current_user = nil
    end
    
    def correct_user
        @user = User.find(params[:id])
        redirect_to(root_url) unless current_user?(@user)
    end
end

