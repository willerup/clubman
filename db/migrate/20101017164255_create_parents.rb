class CreateParents < ActiveRecord::Migration
  def self.up
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
  end

  def self.down
    drop_table :parents
  end
end
