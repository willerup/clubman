class User < ActiveRecord::Base
  acts_as_authentic
  
  belongs_to :family
  belongs_to :club
  has_many :students, :through => :family
  
  belongs_to :group
  
  def self.find_by_login_or_email(login)
    User.find_by_login(login) || User.find_by_email(login)
  end
  
end
