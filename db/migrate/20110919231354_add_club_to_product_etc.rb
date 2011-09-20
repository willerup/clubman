class AddClubToProductEtc < ActiveRecord::Migration
  def self.up
    add_column :products, :club_id, :integer
    add_column :accounts, :club_id, :integer
  end

  def self.down
  end
end
