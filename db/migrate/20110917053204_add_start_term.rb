class AddStartTerm < ActiveRecord::Migration
  def self.up
    add_column :terms, :start_event_id, :integer
  end

  def self.down
  end
end
