class AddAccountToProducts < ActiveRecord::Migration
  def self.up
    add_column :products, :account_id, :integer
    
    income = Account.find_by_name("Income")
    account = Account.create!(:name => 'Registrations', :type => "income")
    product = Product.find_by_name("Registration")
    product.account = account
    product.save
    AccountEvent.where(:credit_id => income).each { |e| e.credit_id = account; e.save }
  end

  def self.down
  end
end
