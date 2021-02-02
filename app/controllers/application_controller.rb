class ApplicationController < ActionController::Base
helper_method [:logged_in?, :current_user, :current_requester, :current_donor, :current_person]
# protect_from_forgery with: :exception
# before_action :authentication_required
#   skip_before_action :authentication_required, only: [:welcome, :login, :signup, :create, :new, :omnicreate]

private


  def current_user
    current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def current_requester
    current_requester ||= Requester.find_by(user_id: session[:user_id])
  end

  def current_donor
    current_donor ||= Donor.find_by(user_id: session[:user_id])
  end
  
  def current_person
    if current_user
      current_person = current_user
    elsif current_requester
      current_person = current_requester
    elsif current_donor
      current_person = current_donor
    else
      flash[:error] = "current_person not set"
    end
  end

  def authentication_required
    if !logged_in?
      redirect_to login_path
    end
  end

#   def auth
#     redirect_to login_url, alert: 'You must login to access that page' unless logged_in?
#   end

  def logged_in?
      !current_user.nil?
  end

  # def require_login
  #   return head(:forbidden) unless session.include? :user_id
  # end

end
