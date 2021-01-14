class SessionsController < ApplicationController
# get request - params are 
    def new
        # binding.pry
        @user = User.new
        render :login
    end

# post request - params are 
    def create
        @user = User.find_or_create_by(name: params[:name])
        binding.pry
        return head(:forbidden) unless 
    @user.authenticate(params[:password])
        session[:user_id] = @user.id
    end

end
