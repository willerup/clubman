class Family < ActiveRecord::Base
  belongs_to :club
  has_many :users
  has_many :students
  belongs_to :account

  def email_trimmed
    email.strip if email
  end
end