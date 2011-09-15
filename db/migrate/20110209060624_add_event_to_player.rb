class AddEventToPlayer < ActiveRecord::Migration
  def self.up
    add_column :players, :event_id, :integer
  end

  def self.down
  end
end
