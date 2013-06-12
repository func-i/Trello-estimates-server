class Admin < ActiveRecord::Base
  attr_accessible :email

  def self.is_manager(email)
    count(:conditions => ["email = ?", email]) > 0
  end
end
