class Account < ActiveRecord::Base
  has_one :family  
  belongs_to :parent, :class_name => "Account", :foreign_key => "parent_id"
  
  
  def is(account_type)
    self.account_type == account_type
  end
  
  def credits
    AccountEvent.all(:conditions => ["credit_id = ? ", id])
  end
  
  def debits
    AccountEvent.all(:conditions => ["debit_id = ? ", id])
  end
  
  def total
    creditTotal = credits.sum(&:amount)
    debitTotal = debits.sum(&:amount)
    sum = debitTotal - creditTotal
    sum = -sum if creditIncreases
    return sum
  end
  
  def creditIncreases
    account_type == :income || account_type == :liability
  end
end


=begin





Budget Only Assets Liabilities Net Assets Revenues Expenses Special Accts
Increase would be a positive number, decrease would be a negative number Increase would be a negative number, decrease would be a positive number Increase would be a negative number, decrease would be a positive number
Normal balance will show
as a positive number
0010-0035, 5500 1000-1999 2000-2999 3000-3999 4000-4899 4900-8999 9000-9999
increase = debit increase = debit increase = credit increase = credit increase = credit increase = debit increase = credit (9250)
decrease = credit decrease = credit decrease = debit decrease = debit (9260) decrease = debit decrease = credit decrease = debit (9260)




=end