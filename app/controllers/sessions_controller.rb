class SessionsController < ApplicationController

# get request - params are 
    def login
        # binding.pry
        @user = User.new
        render :login
    end

    def new
        @user = User.new
    end


# post request - params are 
    def create
        # raise env['omniauth.auth'].to_yaml 
        # binding.pry
        @user = User.find_by(name: params[:name])

        if auth_hash != nil
            @user = User.from_omniauth(auth_hash)
            session[:user_id] = @user.id
            redirect_to requests_path(@user), notice: "Signed in"
        elsif @user && @user.authenticate(params[:password])
            session[:user_id] = @user.id
            current_requester
            render :'/requests/index'
        else
            binding.pry
            flash[:error] =  @user.errors.full_messages 
            render :login
        end
    end

    def logout
        session.clear
        redirect_to root_path 
    end

    def failure
        redirect_to root_url, alert: "Authentication failed, please try again."
    end

    private

    # def user_params
    #     params.require(:user).permit(:name, :password, :role)
    # end

    def auth_hash
        # binding.pry
        request.env['omniauth.auth']
    end

    # def self.github_omniauth(auth)
    #     self.find_or_create_by(name: auth[:info][:name]) do |user|
    #         user.name = auth[:info][:nickname]
    #     end
    # end

    def from_omniauth?
        :provider && :uid
    end
end
