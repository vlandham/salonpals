class ChangeAddressZipToString < ActiveRecord::Migration
  def self.up
    change_table :posts do |t|
      t.remove :address_zip
      t.string :address_zip
    end
  end

  def self.down
    change_table :posts do |t|
      t.remove :address_zip
      t.integer :address_zip
    end
  end
end
