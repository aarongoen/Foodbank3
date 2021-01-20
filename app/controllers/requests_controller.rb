class RequestsController < ApplicationController
#   before_action :authentication_required 
  
    def new
        @request = Request.new
    end

    def create
        @request = Request.create(request_params)
        # binding.pry
        current_request = (current_requester.id == @request.requester_id)
        redirect_to requests_path(current_request)
    end
        
    def show
        @request = Request.find(params[:id])
    end
    
    def index
        # binding.pry
        if current_requester
            @requests = current_requester.requests
        elsif
            current_donor
            @requests = current_donor.requests
        else
            redirect_to new_requests_path
        end
    end
    
 
    private

    def request_params
        params.require(:request).permit(:name, :quantity, :measurement, :requester_id, :donor_id)
    end
    
end
