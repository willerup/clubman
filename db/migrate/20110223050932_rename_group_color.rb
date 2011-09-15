class RenameGroupColor < ActiveRecord::Migration
  def self.up
    rename_column :groups, :color, :style
  end

  def self.down
  end
end
