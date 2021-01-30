class User < ApplicationRecord
  # use OmniAuth::Builder do
  #   provider :identity, :fields => [:email]
  # end
  
  # validates :name, 
  #     presence: { :message => "Please include a name.", on: :update},
  #     uniqueness: { :message => "Username already exisits. Please select a different one."},
  #     length: {in: 3..15, :message => "Username should be 3-5 characters long", :allow_blank => true}


    # validates :password, presence: true
    # validates :password, length: { minimum: 6 }

    # has_secure_password
    
    # validates :role, presence: true

    has_one :requester
    has_one :donor
    has_one :identity

    # def self.find_or_create_from_auth_hash(auth)
    #     @user = User.find_by(name: auth_hash.uid)

    #     if @user 
    #         flash[:notice] = "user signed in with github"
    #         @user 
    #     else
    #         @user = User.find_by(name: auth_hash.uid, password: SecureRandom.hex)
    #         flash[:notice] = "user created in with github" 
    #     end
    # end

    def from_omniauth?
      :provider && :uid
    end

    # def self.from_omniauth(auth)
    #     find_by_provider_and_uid(auth["provider"], auth["uid"]) || create_with_omniauth(auth)
    # end

    def self.create_by_github(auth)
      self.create!(name: auth['info']['nickname'], 
          id: auth['uid']) do |u|
          user.name = auth['info']['nickname']
          user.provider = auth['provider']
          user.password = SecureRandom.hex
      end 
  end 

end
