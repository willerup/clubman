class AddTermToEvent < ActiveRecord::Migration
  def self.up
    add_column :events, :term_id, :integer
    add_column :groups, :club_id, :integer
  end

  def self.down
  end
end
