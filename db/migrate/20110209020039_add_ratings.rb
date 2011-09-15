class AddRatings < ActiveRecord::Migration
  def self.up
      create_table :players do |t|
        t.references :student
        t.integer :rating
        t.datetime :date

        t.timestamps
      end
      
      create_table :games do |t|
        t.integer :player1_id
        t.integer :player2_id
        t.integer :result
        t.references :events
        
        t.timestamps
      end
      
      create_table :events do |t|
        t.string :name
        t.datetime :date
    
        t.timestamps
      end
      
      add_column :students, :grade, :integer
  end

  def self.down
  end
end
