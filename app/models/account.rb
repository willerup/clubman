class Account < ActiveRecord::Base
  belongs_to :family  
  belongs_to :club
  
  LIABILITY = "liability"
  INCOME = "income"
  CASH = "cash"
  EXPENSE = "expense"
  EQUITY = "equity"
  
  
  def is(account_type)
    self.account_type == account_type
  end
  
  def credits
    AccountEvent.all(:conditions => ["credit_id = ? ", self.id])
  end
  
  def debits
    AccountEvent.all(:conditions => ["debit_id = ? ", self.id])
  end
  
  def events
    AccountEvent.where("debit_id = ? OR credit_id = ?", self.id, self.id).order(:date)
  end
  
  def total
    creditTotal = self.credits.sum(&:amount)
    debitTotal = self.debits.sum(&:amount)
    sum = debitTotal - creditTotal
    sum = -sum if self.creditIncreases
    
    return sum
  end
  
  def creditIncreases
    self.account_type == INCOME || self.account_type == LIABILITY || self.account_type == EQUITY
  end

  def self.student_buy(student, product, date)
    AccountEvent.create(
      :product => product,
      :student => student,
      :date => date, :amount => product.price, 
      :credit_note => "#{product.name} for #{student.fullname}",
      :credit => student.club.income,
      :debit_note => "#{product.name} for #{student.firstname}",
      :debit => student.family.account
      )
  end
  
  def self.family_pay(family, amount, date)
      AccountEvent.create(
        :date => date, :amount => amount, 
        :credit_note => "Paid",
        :credit => family.account,
        :debit_note => "Paid by #{family.name}",
        :debit => family.club.cash,
        )
  end
end


