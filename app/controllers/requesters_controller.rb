class RequestersController < ApplicationController
    helper_method :current_requester
      
    def current_requester
        if session[:user_id]
            user = User.find_by(id: user.id)
            @requester = Requester.find_by(user_id: user.id)
        end 
    end
end
