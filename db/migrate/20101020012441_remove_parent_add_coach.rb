class RemoveParentAddCoach < ActiveRecord::Migration
  def self.up
    drop_table :parents
    
    add_column :users, :coach, :boolean
    add_column :users, :admin, :boolean
    add_column :users, :group_id, :integer
  end

  def self.down
    create_table :parents do |t|
      t.string :name
      t.string :phone_home
      t.string :phone_cell
      t.string :phone_work
      t.string :address
      t.string :email

      t.integer :family_id

      t.timestamps
    end
    
    remove_column :users, :coach
    remove_column :users, :admin
    remove_column :users, :group_id
  end
end
