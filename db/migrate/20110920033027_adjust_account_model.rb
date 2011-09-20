class AdjustAccountModel < ActiveRecord::Migration
  def self.up
    add_column :clubs, :liabilities_id, :integer
    remove_column :accounts, :parent_id
  end

  def self.down
  end
end
