class User < ApplicationRecord
    validates :name, presence: true
    validates :name, uniqueness: true
    validates :password, presence: true
    validates :role, presence: true
    has_secure_password

    has_one :requester
    has_one :donor

    # def self.find_or_create_from_auth_hash(auth_hash)
    #     @user = User.find_by(name: auth_hash.uid)

    #     if @user 
    #         flash[:notice] = "user signed in with github"
    #         @user 
    #     else
    #         @user = User.find_by(name: auth_hash.uid, password: SecureRandom.hex)
    #         flash[:notice] = "user created in with github" 
    #     end
    # end

    def self.from_omniauth(auth)
        find_by_provider_and_uid(auth["provider"], auth["uid"]) || create_with_omniauth(auth)
    end

    def self.create_with_omniauth(auth)
        create! do |user|
          user.provider = auth['provider']
          user.uid = auth['uid']
          if auth['info']
             user.name = auth['info']['name'] 
          end
        end
      end


end
