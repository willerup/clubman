class Club < ActiveRecord::Base
  has_many :families
  has_many :students
  has_many :users
  has_many :groups
  
  belongs_to :term
end
