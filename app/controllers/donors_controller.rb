class DonorsController < ApplicationController
    helper_method :current_donor
      
    def current_donor
        if session[:user_id]
            user = User.find_by(id: user.id)
            @donor = Donor.find_by(user_id: user.id)
        end 
    end


end
