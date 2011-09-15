class LinkFamilyToAccount < ActiveRecord::Migration
  def self.up
    add_column :families, :account_id, :integer
    remove_column :accounts, :family_id
  end

  def self.down
    remove_column :families, :account_id
    add_column :accounts, :family_id, :integer
  end
end
