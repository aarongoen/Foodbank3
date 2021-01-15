class User < ApplicationRecord
    has_secure_password
    validates :name, presence: true, uniqueness: true
    validates :password, presence: true
    
    has_one :requesters
    has_one :donors

    # def new

    # end

    # def create

    # end
end
