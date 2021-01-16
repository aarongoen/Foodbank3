class Request < ApplicationRecord
    belongs_to :donors
    belongs_to :requesters

end
