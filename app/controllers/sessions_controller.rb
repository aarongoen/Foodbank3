class SessionsController < ApplicationController
# get request - params are 
    def new
        # binding.pry
        @user = User.new
        render :login
    end

# post request - params are 
    def create
        @user = User.create()    end
end
