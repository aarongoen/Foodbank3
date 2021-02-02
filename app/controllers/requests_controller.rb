class RequestsController < ApplicationController
#   before_action :authentication_required 
  
    def new
        @request = Request.new
    end

    def create
        # binding.pry
        if request_params[:donor_id]
            @request = Request.create(request_params)
            redirect_to requests_show_donations_path(current_person)
        elsif request_params[:requester_id]
            @request = Request.create(request_params)
            redirect_to requester_requests_path(current_person)#, @request)
        else
            "ruh-roh"
            # redirect_to donor_requests_path(current_person)
        end
    end
        
    def show
        # binding.pry
        @request = Request.find_by(id: params[:id])
    end
    
    def index
        if current_requester
            @requester = Requester.find_by(user_id: current_requester.user_id)
            @requests = @requester.requests
            # redirect_to requester_requests_path(current_requester)
        elsif current_donor
            # binding.pry
            @donor = Donor.find_by(user_id: current_donor.user_id)
            @donations = @donor.requests
            @requests = Request.outstanding
# binding.pry
            # redirect_to donor_requests_path(@donor)
        else
            flash[:error] = "Sorry, we can't find requests or donations for you."
        end
    end

    def edit
        # binding.pry
        @request = Request.find_by(id: params[:id])
            if current_requester
                render 'edit_request'
            elsif current_donor
                render 'edit_donation'
            else
                redirect_to new_requests_path
            end
        end

    def update
        # binding.pry
        @request = Request.find_by(id: params[:id]) #|| Request.find_by(requester_id: params[:requester_id])
        # binding.pry
        if current_requester
            @request.update(request_params)
            # binding.pry
            redirect_to requester_requests_path(current_requester)
        elsif current_donor
            @request.update_attributes(request_params)
            redirect_to donor_request_path(@request)
        else
           "not updated"
        end
    end

    def to_fulfill
        # binding.pry
        @requests = Request.outstanding

        render '/requests/to_fulfill'
    end

    def destroy
        # binding.pry
        @request = Request.find(params[:id])
        @request.destroy!
        if current_requester
            redirect_to requester_requests_path, :notice => "Your request has been deleted."
        elsif current_donor
            redirect_to donor_requests_path,  :notice => "Your donation has been deleted."
        else
            @request.errors.full_messages each do |m|
                puts m 
            end
        end

    end
 
    private

    def request_params
        params.require(:request).permit(:name, :quantity, :measurement, :requester_id, :donor_id, :fulfilled)
    end
    
end
