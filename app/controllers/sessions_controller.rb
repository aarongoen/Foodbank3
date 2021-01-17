class SessionsController < ApplicationController
# get request - params are 
    def login
        # binding.pry
        @user = User.new
        render :login
    end

# post request - params are 
    def create
        if auth_hash != nil
            @user = User.find_or_create_from_auth_hash(auth_hash)
            session[:user_id] = @user.id
            redirect_to user_role_requests_path(@user)
        else
        @user = User.new(strong_params)
        # binding.pry
        if @user && @user.authenticate(strong_params[:password])
            # binding.pry
            session[:user_id] = @user.id
            redirect_to user_role_requests_path(@user)
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

    private

    def strong_params
        params.require(:user).permit(:name, :password)
    end

    def auth_hash
        request.env['omniauth.auth']
    end

end
