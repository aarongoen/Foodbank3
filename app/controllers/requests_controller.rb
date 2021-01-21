class RequestsController < ApplicationController
#   before_action :authentication_required 
  
    def new
        @request = Request.new
    end

    def create
        @request = current_requester.requests.build(request_params)
        # binding.pry
        # current_request = (current_requester.id == @request.requester_id)
        redirect_to requester_requests_path(current_requester, @request)
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

    def edit
        @request = Request.find(params[:id])
    end

    def update
        @request = Request.find(params[:id])
        @request.update(name: params[:request][:name], quantity: params[:request][:quantity], measurement: params[:request][:measurement], requester_id: params[:request][:requester_id], donor_id: params[:request][:donor_id])
        redirect_to requester_request_path(@request)
    end
    
 
    private

    def request_params
        params.require(:request).permit(:name, :quantity, :measurement, :requester_id, :donor_id)
    end
    
end
