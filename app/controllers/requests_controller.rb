class RequestsController < ApplicationController
    # before_action :require_login
    # skip_before_action :require_login, only: [:index]
  
    def show
        @request = Request.find(params[:id])
    end
    
    def index
        binding.pry
        @requests = current_requester.requests
    end
    
    def create
        @request = Request.create(request_params)
    end
    
    private
    
    def require_login
        return head(:forbidden) unless session.include? :user_id
    end

    def request_params
        params.require(:quantity)
    end
    
end
