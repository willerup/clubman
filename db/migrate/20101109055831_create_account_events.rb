class CreateAccountEvents < ActiveRecord::Migration
  def self.up
    create_table :account_events do |t|
      t.integer :debit_id
      t.integer :credit_id
      t.string :description
      t.datetime :date
      t.integer :amount

      t.timestamps
    end
  end

  def self.down
    drop_table :account_events
  end
end
