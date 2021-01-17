class ApplicationController < ActionController::Base
helper_method [:logged_in?, :current_user, :current_requester, :current_donor]
  # before_action :require_login
  # skip_before_action :require_login, only: [:index]
private

  def current_user
     @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

#   def auth
#     redirect_to login_url, alert: 'You must login to access that page' unless logged_in?
#   end

    def current_requester
      @current_requester ||= Requester.find_by(user_id: session[:user_id])
    end

    def current_donor
      @current_donor ||= Donor.find_by(user_id: session[:user_id])
    end

    def logged_in?
        !!current_donor
    end

    # def require_login
    #   return head(:forbidden) unless session.include? :user_id
    # end

end
