class RenameEventInGame < ActiveRecord::Migration
  def self.up
    rename_column :games, :events_id, :event_id
  end

  def self.down
  end
end
