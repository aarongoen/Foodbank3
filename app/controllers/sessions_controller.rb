class SessionsController < ApplicationController
    skip_before_action :verify_authenticity_token, only: [:login, :new, :create, :omni_create]
    # before_action :authentication_required
    # skip_before_action :logged_in?, only: [:login, :new, :create, :omni_create]
    # skip_before_action :authentication_required, only: [:omnicreate, :login, :welcome, :new]
require 'securerandom'

    def login
        # binding.pry
        @user = User.new
        render :login
    end

    def new
        # binding.pry
    end

    def omnicreate
        # binding.pry
   
        @user = User.find_or_create_by(uid: auth['uid']) do |user| 
                user.name = auth['info']['nickname']
                user.provider = auth['provider']
                user.uid = auth['uid']
                user.password = 'something secure in the future'
            end
            # binding.pry
                if @user && @user.save(validate: false)
                    # binding.pry
                    session[:user_id] = @user.id
                    # binding.pry
                    if @user.role.nil?
                        binding.pry
                        redirect_to edit_user_path(@user)
                    else
                        redirect_to requests_path(current_person.role)
                    end
                else 
                    # binding.pry
                    # if get '/auth/failure' do
                    #     flash[:notice] = params[:message] # if using sinatra-flash or rack-flash
                    #     redirect root_path
                    #   end
                    redirect_to root_path
                end
            # binding.pry        
    end

# post request - params are 
    def create
        # binding.pry
        @user = User.find_by(name: params[:name])
        # binding.pry
        if @user && @user.authenticate(params[:password])
            binding.pry
            session[:user_id] = @user.id
            redirect_to requests_path, notice: "Signed in"
        else
            binding.pry
            flash[:errors]
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


    # def from_omniauth?
    #     :provider && :uid
    # end

    private 


    def logged_in?
        !current_user.nil?
    end

    def user_params
        params.require(:user).permit(:name, :password, :provider, :uid)
    end

    def authentication_required
        if !logged_in?
          redirect_to login_path
        end
      end

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
