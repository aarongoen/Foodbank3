class SessionsController < ApplicationController
    skip_before_action :verify_authenticity_token, only: :omni_create

    def login
        # binding.pry
        @user = User.new
        render :login
    end

    def new

    end

    def omnicreate
        # binding.pry
        # if get '/auth/failure' do
        #     flash[:notice] = params[:message] # if using sinatra-flash or rack-flash
        #     redirect root_path
        #   end
        @user = User.find_or_create_by(uid: auth['uid']) do |user| 
                # user.name = auth['info']['nickname']
                # user.provider = auth['provider']
                user.uid = auth['uid']
            end
            # binding.pry
                if @user && @user.save
                    # binding.pry
                    session[:user_id] = @user.id
                    # binding.pry
                    redirect_to edit_user_path(@user)
                else 
                    # binding.pry
                    redirect_to root_path
                end
            # binding.pry        
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

    def user_params
        params.require(:user).permit(:name, :password)
    end

    # def from_omniauth?
    #     :provider && :uid
    # end

    private 

    # def omni_create
    #     # binding.pry
    #     # if get '/auth/failure' do
    #     #     flash[:notice] = params[:message] # if using sinatra-flash or rack-flash
    #     #     redirect root_path
    #     #   end
    #     if @user = User.find_or_create_by(name: auth['info']['nickname'], 
    #         id: auth['uid']) do |user| 
    #             user.name = auth['info']['nickname']
    #             user.provider = auth['provider']
    #             user.id = auth['uid']
    #         end
    #         # binding.pry
    #             @user.save
    #         # binding.pry
    #         session[:user_id] = @user.id
    #             # binding.pry
    #         render 'users/edit'
    #     else
    #         Rails.logger.debug params.inspect        
    #         render :omni_error
    #     end
    # end

    protected 

    def auth
        request.env['omniauth.auth']
    end

   
end
