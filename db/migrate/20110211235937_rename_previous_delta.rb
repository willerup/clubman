class RenamePreviousDelta < ActiveRecord::Migration
  def self.up
    rename_column :players, :previous_rating, :delta
    
  end

  def self.down
  end
end
