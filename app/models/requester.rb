class Requester < ApplicationRecord
    has_many :requests
    has_many :donors, through: :requests
end
