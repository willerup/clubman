class AccountEvent < ActiveRecord::Base
  belongs_to :debit, :class_name => "Account", :foreign_key => "debit_id"
  belongs_to :credit, :class_name => "Account", :foreign_key => "credit_id"

  belongs_to :student
  belongs_to :product
  
end
