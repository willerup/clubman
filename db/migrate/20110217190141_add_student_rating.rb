class AddStudentRating < ActiveRecord::Migration
  def self.up
    add_column :students, :rating, :integer
  end

  def self.down
  end
end
