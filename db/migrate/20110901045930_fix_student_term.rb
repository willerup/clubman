class FixStudentTerm < ActiveRecord::Migration
  def self.up
    remove_column :students_terms, :id
  end

  def self.down
  end
end
