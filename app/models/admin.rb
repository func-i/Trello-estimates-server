class Admin < ActiveRecord::Base
  attr_accessible :email

  validates :email,
            :presence => true

  def self.is_manager(email)
    count(:conditions => ["email = ?", email]) > 0
  end
end
