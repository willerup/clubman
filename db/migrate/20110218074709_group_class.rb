class GroupClass < ActiveRecord::Migration
  def self.up
    add_column :groups, :class, :string
  end

  def self.down
  end
end
