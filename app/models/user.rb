class User < ActiveRecord::Base

  def self.already_on_db(email)
    where(email: email).count > 0
  end

  def self.authenticate_user(email, auth_token)
    user = where("email = ?", email).first
    #User already saved on db
    if user.auth_token == auth_token
      user
    else
      #token outdated needs to be updated first
      user.auth_token = auth_token
      user.save!
      user
    end
  end

end