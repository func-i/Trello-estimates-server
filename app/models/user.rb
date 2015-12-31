class User < ActiveRecord::Base
  # attr_accessible :auth_token,
  #                 :email

  scope :already_on_db, lambda { |email| count(:conditions => ["email = ?", email]) > 0 }

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