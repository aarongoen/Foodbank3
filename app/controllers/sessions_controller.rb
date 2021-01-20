class SessionsController < ApplicationController
# get request - params are 
    def login
        # binding.pry
        @user = User.new
        render :login
    end

# post request - params are 
    def create
# binding.pry
        # if auth_hash != nil
        #     @user = User.find_or_create_from_auth_hash(auth_hash)
        #     session[:user_id] = @user.id
        #     redirect_to sessions_path(@user)
        @user = User.find_by(name: params[:name])
            # binding.pry
        if @user && @user.authenticate(params[:password])
            # binding.pry
            session[:user_id] = @user.id
            # binding.pry
            if current_donor
                render :requests_path
            else current_requester
                # binding.pry
                render :'/requests/index'
            end

        else
            flash[:alert] =  "Invalid name or password" #@user.errors.full_messages 
            render :login
        end
    end

    def logout
        session.clear
        # current_user = nil
        # binding.pry
        redirect_to root_path 
    end

    private

    # def user_params
    #     params.require(:user).permit(:name, :password, :role)
    # end

    def auth_hash
        request.env['omniauth.auth']
    end

end
