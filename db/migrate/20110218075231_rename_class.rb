class RenameClass < ActiveRecord::Migration
  def self.up
    rename_column :groups, :class, :color
  end

  def self.down
  end
end
