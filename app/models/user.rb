class User < ApplicationRecord
  # use OmniAuth::Builder do
  #   provider :identity, :fields => [:email]
  # end
  
  validates :name, 
      presence: { :message => "Please include a name."},#, on: :update},
      uniqueness: { :message => "Username already exists. Please select a different one."},
      length: {in: 3..15, :message => "Username should be 3-15 characters long", :allow_blank => false}


  validates :password, 
      presence: true

  has_secure_password
    
  has_one :requester
  has_one :donor

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
