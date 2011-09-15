class AddYearAndClub < ActiveRecord::Migration
  def self.up
    create_table :terms do |t|
       t.string :name
       t.integer :club_id
       t.timestamps
     end
     
     add_column :clubs, :term_id, :integer
     
     create_table :students_terms do |t|
        t.references :students
        t.references :terms
      end
      
      add_column :students, :club_id, :integer
      add_column :students, :current, :boolean
  end

  def self.down
  end
end
