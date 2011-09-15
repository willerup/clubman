class AccountCreateParent < ActiveRecord::Migration
  def self.up
    add_column :accounts, :parent_id, :integer
  end

  def self.down
  end
end
