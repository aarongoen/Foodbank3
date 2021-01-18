class SessionsController < ApplicationController
# get request - params are 
    def login
        # binding.pry
        @user = User.new
        render :login
    end

# post request - params are 
    def create
        binding.pry
        user_params = params.require(:user).permit(:name, :password, :role)
if
        # if auth_hash != nil
        #     @user = User.find_or_create_from_auth_hash(auth_hash)
        #     session[:user_id] = @user.id
        #     redirect_to sessions_path(@user)
        # elsif
            @user = User.find_by(name: user_params[:name])
            if @user && @user.authenticate(user_params[:password])
            binding.pry
            session[:user_id] = @user.id
            redirect_to requester_requests_path(@user.id)

            binding.pry
        else
            flash[:alert] = "Invalid name or password" #"@user.errors.full_messages"
            render :login
        end
    end

    def destroy
        session.delete(:current_user_id)
        current_user = nil
        redirect_to root_url, notice: "Logged out"
    end

    private

    def user_params
        params.require(:user).permit(:name, :password, :role)
    end

    def auth_hash
        request.env['omniauth.auth']
    end

end
