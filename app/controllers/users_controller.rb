class UsersController < ApplicationController
    def new
        @user = User.new
    end
    
    def create
        @user = User.new(user_params)
        # binding.pry
        if @user.valid?
            binding.pry
            @user.save
            # binding.pry
             if @user.role == "donor"
                @donor = Donor.create(name: @user.name, user_id: @user.id)
                # binding.pry
                redirect_to requests_path
             elsif @user.role == "requester"
                @requester = Requester.create(name: @user.name, user_id: @user.id)
                redirect_to requests_path
             end
        else 
            redirect_to signup_path
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
