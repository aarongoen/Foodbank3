class RequestsController < ApplicationController
  before_action :authentication_required 
  
    def show
        @request = Request.find(params[:id])
    end
    
    def index
        # binding.pry
        if params[:donor_id]
            @requests = Donor.find(params[:donor_id]).requests
        elsif params[:requester_id]
            @requests = Requester.find(params[:requester_id]).requests
        else
            @requests = Request.all
        end
    end
    
    def create
        @request = Request.create(request_params)
        @request.save
    end
    
    private

    def request_params
        params.require(:request).permit(:name, :quantity, :measurement)
    end
    
end
