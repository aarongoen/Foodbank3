class SessionsController < ApplicationController
# get request - params are 
    def login
        # binding.pry
        @user = User.new
        render :login
    end

# post request - params are 
    def create
        @user = User.find_by(name: params[:user][:name])
        # binding.pry
        if @user && @user.authenticate(strong_params[:password])
            # binding.pry
            session[:user_id] = @user.id
            redirect_to @user #or root path?
        else
            flash[:error] = "@user.errors.full_messages"
            @user = User.new(name: strong_params[:name])
            render :signup
        end
    end

    def logout
        session.clear
        redirect_to root_path
    end

end
