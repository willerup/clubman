class GroupsStudents < ActiveRecord::Migration
  def self.up
    rename_table :students_groups, :groups_students
  end

  def self.down
  end
end
