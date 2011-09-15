class AddAccountTypes < ActiveRecord::Migration
  def self.up
    add_column :accounts, :account_type, :string
      end

  def self.down
  end
end
