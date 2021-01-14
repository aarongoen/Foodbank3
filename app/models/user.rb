class User < ApplicationRecord
    has_many :requesters
    has_many :donors
end
