class PreviousRating < ActiveRecord::Migration
  def self.up
    add_column :players, :previous_rating, :integer
  end

  def self.down
  end
end
