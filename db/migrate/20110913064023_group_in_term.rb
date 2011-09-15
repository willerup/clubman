class GroupInTerm < ActiveRecord::Migration
  def self.up
    rename_column :groups, :club_id, :term_id
  end

  def self.down
  end
end
