class Request < ApplicationRecord
    belongs_to :donor, optional: true
    # validates :donor_id, presence: true, allow_nil: true

    belongs_to :requester, optional: true
    # validates :requester_id, presence: true, allow_nil: true

    private 

    def requester_id_or_donor_id
        if @request[:donor_id]
            @request[:requester_id] = nil
        elsif @request[:requester_id]
            @request[:donor_id] = nil
        else
            flash[:error] = "Requires either donor or requester id."
        end
    end

#     def request_attributes=(request)
#       self.request = Request.find_or_create_by(name: request[:name])
#       self.request.update(request)
#     end
end
