class Requester < ApplicationRecord
    has_many :requests
    has_many :donors, through: :requests
    accepts_nested_attributes_for :requests

end
