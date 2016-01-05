class Admin < ActiveRecord::Base
  
  validates :email, presence: true

  def self.is_manager(email)
    count(:conditions => ["email = ?", email]) > 0
  end
end
