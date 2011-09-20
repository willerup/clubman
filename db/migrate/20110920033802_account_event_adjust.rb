class AccountEventAdjust < ActiveRecord::Migration
  def self.up
    remove_column :account_events, :description
    add_column :account_events, :credit_note, :string
    add_column :account_events, :debit_note, :string
  end

  def self.down
  end
end
