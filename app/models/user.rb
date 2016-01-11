class User < ActiveRecord::Base

  def self.already_on_db(email)
    where(email: email).count > 0
  end

  def self.authenticate_user(email, auth_token)
    user = where(email: email).first
    
    if user.auth_token !== auth_token
      user.auth_token = auth_token
      user.save!
    end

    user
  end

end