class User < ApplicationRecord
    has_secure_password
    validates :name, presence: true, uniqueness: true
    validates :password, presence: true
    validates :role, presence: true
    
    has_one :requester
    has_one :donor


 
end
