class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,:omniauthable
def self.find_for_mock(auth)
    parameters = { 
      name:     auth.info.name,
      email:    auth.info.email,
      provider: auth.provider,
      uid:      auth.uid,
      token:    auth.credentials.token,
      password: Devise.friendly_token[0, 20],
      raw: auth.extra.to_json
    }   
    user = User.find_by(uid: auth.uid)
    return update_mock!(user, parameters) if user

    User.create(parameters)
  end 

  def self.update_mock!(user, parameters)
    user.update(parameters)
    user
  end 
end
