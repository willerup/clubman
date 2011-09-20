class AddAccountsToClub < ActiveRecord::Migration
  def self.up
    add_column :clubs, :income_id, :integer
    add_column :clubs, :expenses_id, :integer
    add_column :clubs, :cash_id, :integer
  end

  def self.down
  end
end
