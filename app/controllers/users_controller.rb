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
        # binding.pry
        if @user.valid? && @user.role == "donor"
            @user.save
            @donor = Donor.create(name: @user.name, user_id: @user.id)
            session[:user_id] = @user.id
            # binding.pry
            redirect_to donor_requests_path(@donor)
        elsif 
            # binding.pry
            @user.valid? && @user.role == "requester"
            @user.save
            @requester = Requester.create(name: @user.name, user_id: @user.id)
            session[:user_id] = @user.id
            redirect_to requests_path(@requester)
        else
            flash[:alert] = "Name or password not valid."
            redirect_to signup_path
        end
    end

    def edit
        @user = User.find(params[:id])
        @name = @user.name
    end

    def update
        # binding.pry
        @user = User.find_by(id: params['id'])
        # unless 
        # binding.pry
            @user.update(user_params)
            # flash[:error] = "There was a problem updating the user's attributes with params."
        # end
        # binding.pry
        if @user.role == 'donor'
            binding.pry
            @donor = Donor.find_or_create_by(user_params)
            binding.pry
            redirect_to donor_requests_path(@donor)
        elsif @user.role == 'requester'
            @requester = Requester.find_or_create_by(user_params)
            binding.pry
            redirect_to requester_requests_path(@requester)
        else 
            flash[:error] = "There was a problem in the user's update action."
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


