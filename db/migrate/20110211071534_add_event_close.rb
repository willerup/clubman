class AddEventClose < ActiveRecord::Migration
  def self.up
    add_column :events, :closed, :boolean
  end

  def self.down
  end
end
