class SessionsController < ApplicationController
    # skip_before_action :authentication_required

    def login
        # binding.pry
        @user = User.new
        render :login
    end

    def new

    end

    def omni_create 
        # binding.pry
        @user = User.find_or_create_by.(provider: auth['provider'], uid: auth['uid']) do |user| 
            user.provider = auth['provider']
            user.uid = auth['uid']
        end
            if @user.save
                session[:user_id] = user.id
                redirect_to requests_path
            else
                redirect_to '/'
            end
    end

# post request - params are 
    def create
        @user = User.find_by(name: params[:name])
        # binding.pry
        if @user && @user.authenticate(params[:password])
            session[:user_id] = @user.id
            redirect_to requests_path, notice: "Signed in"
        else
            # binding.pry
            flash[:alert] =  "Login unsuccessful. Try again."
            render :login
        end
    end

    def logout
        session.clear
        redirect_to root_url
    end

    def failure
        redirect_to root_url, alert: "Authentication failed, please try again."
    end

    # def user_params
    #     params.require(:user).permit(:name, :password, :role)
    # end

    # def from_omniauth?
    #     :provider && :uid
    # end

    protected 

    def auth
        request.env["omniauth.auth"]
    end

   
end
