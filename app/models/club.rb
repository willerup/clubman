class Club < ActiveRecord::Base
  has_many :families
  has_many :students
  has_many :users
  has_many :groups
  has_many :products
  has_many :accounts
  
  belongs_to :term
  
  belongs_to :income, :class_name => 'Account', :foreign_key => 'income_id'
  belongs_to :expenses, :class_name => 'Account', :foreign_key => 'expenses_id'
  belongs_to :cash, :class_name => 'Account', :foreign_key => 'cash_id'
  belongs_to :liabilities, :class_name => 'Account', :foreign_key => 'liabilities_id'
  
  
  def init_accounts
    if !self.income
      self.income = Account.create(:name => 'Income', :account_type => Account::INCOME, :club => self)
    end
    if !self.expenses
      self.expenses = Account.create(:name => 'Expenses', :account_type => Account::EXPENSE, :club => self)
    end
    if !self.cash
      self.cash = Account.create(:name => 'Cash', :account_type => Account::CASH, :club => self)
    end
    if !self.liabilities
        self.liabilities = Account.create(:name => 'Liabilities', :account_type => Account::LIABILITY, :club => self)
    end
    self.save!
  end
end
