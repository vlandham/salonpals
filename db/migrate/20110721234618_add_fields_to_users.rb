class AddFieldsToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :language, :integer
    add_column :users, :zip_code, :integer
  end

  def self.down
    remove_column :users, :zip_code
    remove_column :users, :language
    remove_column :users, :last_name
    remove_column :users, :first_name
  end
end
