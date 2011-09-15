class AddClub < ActiveRecord::Migration
  def self.up
    add_column :users, :club_id, :integer
  end

  def self.down
  end
end
