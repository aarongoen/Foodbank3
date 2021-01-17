class RequestsController < ApplicationController
  
  
    def show
        @request = Request.find(params[:id])
    end
    
    def index
        # binding.pry
        @requests = current_requester.requests
    end
    
    def create
        @request = Request.create(request_params)
    end
    
    private

    def request_params
        params.require(:quantity)
    end
    
end
