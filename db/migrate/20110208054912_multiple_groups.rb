class MultipleGroups < ActiveRecord::Migration
  def self.up
    remove_column :students, :group_id
    
    create_table :students_groups do |t|
      t.references :students
      t.references :groups

      t.timestamps
    end
  end

  def self.down
  end
end
