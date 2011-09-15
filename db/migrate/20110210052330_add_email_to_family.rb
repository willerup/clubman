class AddEmailToFamily < ActiveRecord::Migration
  def self.up
    add_column :families, :email, :string
    add_column :families, :phone, :string
    add_column :families, :notes, :string
  end

  def self.down
  end
end
