class Request < ApplicationRecord
    belongs_to :donors
    belongs_to :requesters

    # def new
    # end
    
    # def create
    #     @request = Request.create(name: params[:name], quantity: params[:quantity])
    # end

    # private

    # def valid?

    # end
end
