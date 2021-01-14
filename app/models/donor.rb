class Donor < ApplicationRecord
    has_many :requests
    has_many :requesters, through: :requests
end
