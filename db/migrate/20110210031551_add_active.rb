class AddActive < ActiveRecord::Migration
  def self.up
    add_column :students, :active, :boolean
  end

  def self.down
  end
end
