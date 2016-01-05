class Admin < ActiveRecord::Base
  
  validates :email, presence: true

  def self.is_manager(email)
    where(email: email]).count > 0
  end
  
end
