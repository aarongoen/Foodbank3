class UsersController < ApplicationController
    def new
        @user = User.new
    end
    
    def create
        @user = User.new(user_params)
        # binding.pry
        if  @user.valid?
            # binding.pry
            @user.save
            # if @user.type == "donor"
                redirect_to requests_path
        else 
            redirect_to signup_path
        end
    end

    def show
        @user = User.find(params[:id])
    end

    private
 
    def user_params
      params.require(:user).permit(:name, :password)
    end
end
