class AddMissingFieldsToAccount < ActiveRecord::Migration
  def self.up
    add_column :account_events, :product_id, :integer
    add_column :account_events, :student_id, :integer
      
        create_table :products do |t|
          t.string :name
          t.integer :price

          t.timestamps
        end
  end

  def self.down
  end
end
