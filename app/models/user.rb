class User < ApplicationRecord
    has_secure_password
    
    has_one :requesters
    has_one :donors

    def new

    end

    def create

    end
end
