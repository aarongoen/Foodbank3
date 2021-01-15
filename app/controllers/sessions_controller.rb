class SessionsController < ApplicationController
# get request - params are 
    def new
        # binding.pry
        @user = User.new
        render :login
    end

# post request - params are 
    def create
        @user = User.find_by(name: params[:name])
        # binding.pry
        if @user && @user.authenticate(params[:password])
            session[:user_id] = @user.id
            redirect_to @user
        else
            @error = "didn't work"
            redirect_to login_path
        end
    end

    def logout
        session.clear
        redirect_to login_path
    end

end
