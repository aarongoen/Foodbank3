module SessionsHelper
    def authentication_required
        if !logged_in?
          redirect_to login_path
        end
      end
end
