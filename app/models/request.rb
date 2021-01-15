class Request < ApplicationRecord
    belongs_to :donors
    belongs_to :requesters

    def new
    end
    
    def create
        @request = Request.create(request_params)
    end

    private

    def request_params
        params.require(:name).allow(:quantity)
    end

    # def valid?

    # end
end
