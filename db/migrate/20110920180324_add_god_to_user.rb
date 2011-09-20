class AddGodToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :god, :boolean
    u = User.find_by_login("fredw")
    u.god = true
    u.save
  end

  def self.down
  end
end
