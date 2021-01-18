class User < ApplicationRecord
    validates :name, presence: true
    validates :name, uniqueness: true
    validates :password, presence: true
    validates :role, presence: true
    has_secure_password

    has_one :requester
    has_one :donor

    def self.find_or_create_from_auth_hash(auth_hash)
        @user = User.find_by(name: auth_hash.uid)

        if @user 
            # flash[:error] = "user sign in with github"
            @user 
        else
            # flash[:error] = "user created in with github" 
            @user = User.find_by(name: auth_hash.uid, password: SecureRandom.hex)
        end
    end


end
