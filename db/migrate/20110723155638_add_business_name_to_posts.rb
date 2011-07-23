class AddBusinessNameToPosts < ActiveRecord::Migration
  def self.up
    add_column :posts, :business_name, :string
  end

  def self.down
    remove_column :posts, :business_name
  end
end
