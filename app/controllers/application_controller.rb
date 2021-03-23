class ApplicationController < ActionController::Base

   private

   def login_required
     if !logged_in?
       flash[:notice] = "Log in to edit or delete your
       Post"
       redirect_to root_path
     end
   end

   def current_user
     @current_user ||= User.find(session[:user_id]) if
     session[:user_id].present?
   end

   helper_method :current_user

   def logged_in?
     !!current_user
   end

   helper_method :logged_in?
end
