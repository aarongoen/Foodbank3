class Request < ApplicationRecord
    belongs_to :donors
    belongs_to :requesters

#     def request_attributes=(request)
#       self.request = Request.find_or_create_by(name: request[:name])
#       self.request.update(request)
#     end
end
