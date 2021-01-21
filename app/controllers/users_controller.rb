class UsersController < ApplicationController
    def new
        @user = User.new
    end
    
    def create
        @user = User.new(user_params)
        # binding.pry
        if @user.valid?
            # binding.pry
            @user.save
            # binding.pry
            session[:user_id] = @user.id
             if current_donor
                @donor = Donor.create(name: @user.name, user_id: @user.id)
                redirect_to requests_path(current_donor)
             else current_requester
                @requester = Requester.create(name: @user.name, user_id: @user.id)
                redirect_to requests_path(current_requester)
             end
        else 
           render :'sessions/login'
        end
    end

    def show
        @user = User.find(params[:id])
    end

    private
 
    def user_params
      params.require(:user).permit(:name, :password, :role)
    end
end
