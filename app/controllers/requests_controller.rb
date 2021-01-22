class RequestsController < ApplicationController
#   before_action :authentication_required 
  
    def new
        @request = Request.new
    end

    def create
        # binding.pry
        @request = Request.create(request_params)
        redirect_to requester_requests_path(current_requester)#, @request)
    end
        
    def show
        @request = Request.find_by(id: params[:id])
    end
    
    def index
        # binding.pry
        
        if current_requester
            @requests = current_requester.requests
        elsif current_donor
            @requests = current_donor.requests
        else
            redirect_to new_requests_path
        end
    end

    def edit
        # binding.pry
        @request = Request.find_by(id: params[:id])
    end

    def update
        # binding.pry
        @request = Request.find_by(id: params[:id])

        if @request.update(request_params)
            redirect_to requester_request_path(@request)
        else
            render 'edit'
        end
    end

    def destroy
        # binding.pry
        @request = Request.find_by_id(params[:id]).destroy
        redirect_to requester_requests_path
    end
 
    private

    def request_params
        params.require(:request).permit(:name, :quantity, :measurement, :requester_id, :donor_id)
    end
    
end
