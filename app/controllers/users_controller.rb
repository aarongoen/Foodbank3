class UsersController < ApplicationController
    # skip_before_action :require_login, only: [:new, :create]
    
    def new
        @user = User.new
    end
    
    # def github_create
    #     auth_hash = request.env["omniauth.auth"]
    
    #     user = User.find_by(uid: auth_hash[:uid], provider: "github")
    #     if user
    #         flash[:success] = "Logged in as returning user #{user.username}"
    #     else
    #         user = User.build_from_github(auth_hash)
    #         if user.save
    #             flash[:success] = "Logged in as new user #{user.username}"
    #         else
    #             flash[:error] = "Could not create new user account: #{user.errors.messages}"
    #             redirect_to root_path
    #         end
    #     end
    #     session[:user_id] = user.id
    #     redirect_to root_path
    #     end
    # end

    def create
        @user = User.new(user_params)
        #binding.pry
        if @user.valid?
            # binding.pry
            @user.save
            # binding.pry
            session[:user_id] = @user.id
            # binding.pry
             if @user.role == "donor"
                @donor = Donor.create(name: @user.name, user_id: @user.id)
                redirect_to requests_path(current_donor)
             else @user.role == "requester"
                @requester = Requester.create(name: @user.name, user_id: @user.id)
                redirect_to requests_path(current_requester)
             end
        else 
        flash[:alert] = "Name or password not valid."
           redirect_to signup_url
        end
    end

    def show
        @user = User.find(params[:id])
    end

    private
 
    def user_params
      params.require(:user).permit(:name, :password, :role, :email, :provider, :uid)
    end
end
