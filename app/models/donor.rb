class Donor < ApplicationRecord
    has_many :requests
    has_many :requesters, through: :requests
    accepts_nested_attributes_for :requests

end
