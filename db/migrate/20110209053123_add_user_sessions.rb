class AddUserSessions < ActiveRecord::Migration
  def self.up
    add_column :accounts, :family_id, :integer
  end

  def self.down
  end
end
